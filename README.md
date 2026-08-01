# OpenAPI

[![Build Status](https://github.com/zweidenker/OpenAPI/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/zweidenker/OpenAPI/actions/workflows/build.yml)

This is an implementation of the [OpenAPI 3.0](https://spec.openapis.org/oas/v3.0.4.html) specification for the [Pharo](http://pharo.org) language. It models an OpenAPI document as an object tree, validates whole documents against the official OAI meta-schema, and can drive an HTTP client from a loaded document. It builds on [JSONSchema](https://github.com/zweidenker/JSONSchema) for schema parsing and validation.

The framework is split into three packages:

- **`OpenAPI-Core`** — the document object model (`OpenAPI`, `OAInfo`, `OAPathItem`, `OAOperation`, `OAParameter`, `OASchemaDefinition`, …), parsing/serialization, and `OADocumentValidator` for validating a document against the spec.
- **`OpenAPI-Client`** — builds and fires HTTP requests from a loaded document (`OpenApiClient`, `OARequestBuilder`), including the full OAI parameter style/explode matrix.
- **`OpenAPI-REST`** — a server-side routing layer on top of Zinc (`OpenAPICall`, `OpenAPIUriSpace`). This package is effectively unmaintained legacy code (see [What is (not yet) supported](#what-is-not-yet-supported)) — new work should not depend on it.

## Contents

- [Installation](#installation)
- [Quick start](#quick-start)
- [Parsing and serializing documents](#parsing-and-serializing-documents)
- [Validating documents](#validating-documents)
- [Building requests with OpenAPI-Client](#building-requests-with-openapi-client)
- [Parameter locations and styles](#parameter-locations-and-styles)
- [What is (not yet) supported](#what-is-not-yet-supported)

## Installation

Load it into Pharo via Metacello:

```smalltalk
Metacello new
  repository: 'github://zweidenker/OpenAPI';
  baseline: #OpenAPI;
  load.
```

This loads the `default` group (`OpenAPI-Core` + `OpenAPI-REST` + `OpenAPI-Client`, plus their tests). Load a specific group instead if you only need part of it, e.g. `load: #('Client')` to get `OpenAPI-Core` + `OpenAPI-Client` while skipping the REST layer entirely.

## Quick start

```smalltalk
"Parse a document..."
api := OpenAPI fromString: someOpenApiJsonString.
api info title.       "e.g. 'Swagger Petstore'"
api openapi.           "e.g. '3.0.0'"
api paths keys.        "e.g. #('/pets' '/pets/{petId}')"

"...and check whether it's actually a valid OpenAPI 3.0 document."
OADocumentValidator isValidDocument: someOpenApiJsonString.   "-> true/false"
```

## Parsing and serializing documents

`OpenAPI fromString:` parses a JSON document into the full object model (`OAInfo`, `OAPathItem`, `OAOperation`, `OAParameter`, `OASchemaDefinition`, …) and resolves `$ref`s within it. The result can be serialized back to JSON:

```smalltalk
api := OpenAPI fromString: jsonString.
api specString.   "-> the document, serialized back to JSON"
```

Parsing/serialization is best-effort, not a strict round-trip guarantee: a small number of schema keyword combinations don't survive `specString` unchanged (see [What is (not yet) supported](#what-is-not-yet-supported)).

## Validating documents

`OADocumentValidator` checks a whole document against the official OAI 3.0 meta-schema (bundled verbatim, Apache-2.0 — see `OAMetaSchema`), not just individual parameter values:

```smalltalk
OADocumentValidator isValidDocument: jsonStringOrDictionary.        "-> Boolean"
OADocumentValidator validateDocument: jsonStringOrDictionary.       "-> the parsed document, or raises a JSONSchemaError"
OADocumentValidator validationErrorMessageFor: jsonStringOrDictionary.
  "-> nil if valid, otherwise e.g. 'JSONSchemaMissingRequiredProperty: ...'"
```

The built meta-schema is cached per major.minor version, so repeated validation doesn't rebuild it every time. Only the **first** validation error is reported — JSONSchema-Core signals on the first constraint violation rather than accumulating a full list.

`OAExampleDocuments` bundles six real-world OpenAPI 3.0 documents (petstore, petstore-expanded, api-with-examples, callback-example, link-example, uspto) taken verbatim from the official [OAI/OpenAPI-Specification](https://github.com/OAI/OpenAPI-Specification) repository (Apache-2.0) — the same fixtures the OAI project itself uses to test its meta-schema. Useful as realistic test data beyond hand-written minimal documents.

## Building requests with OpenAPI-Client

Subclass `OpenApiClient` and implement `buildOpenApi` to supply the parsed document; `baseUri` sets the server to talk to. Requests are then made by operation ID:

```smalltalk
MyApiClient class >> buildOpenApi [
  ^ OpenAPI fromString: myOpenApiJsonString
]

client := MyApiClient new.
client baseUri: 'https://api.example.com/v1'.
client call: 'listPets' withArguments: (Dictionary new at: 'limit' put: 5; yourself).
```

`call:withArguments:` looks up the operation by `operationId`, builds the request (path/query/header/cookie parameters, JSON or form-urlencoded body as declared by the operation), fires it, and returns the parsed response body on success. A spec-level violation caught before the request is even sent (e.g. a missing required parameter) raises an `OAError` subclass; any non-2xx response raises `OAUnspecifiedError` with the parsed error body attached. Nested request bodies (e.g. `metadata[key]`, `items[0][price]`) are flattened automatically for form-urlencoded bodies.

## Parameter locations and styles

All four parameter locations and the full OAI style/explode matrix are supported when building requests:

| Location | Supported styles | Default style | Default explode |
| --- | --- | --- | --- |
| `path` | `simple`, `label`, `matrix` | `simple` | `false` |
| `query` | `form`, `spaceDelimited`, `pipeDelimited`, `deepObject` | `form` | `true` |
| `header` | `simple` | `simple` | `false` |
| `cookie` | `form` | `form` | `true` |

`deepObject` and `form`+`explode:true` on an object both expand into multiple top-level parameters (one per property) rather than a single value, per spec. Cookies are a documented special case: the spec leaves `form`+`explode:true` on a non-primitive value undefined for cookies (you can't repeat a cookie name the way you repeat a query key), so arrays/objects are comma-joined into the single cookie value instead.

## What is (not yet) supported

This targets **OpenAPI 3.0** specifically — not a full implementation of every version or every edge case. Known gaps:

- **3.1 / 3.2 are not supported**, and this is a deliberate decision, not an oversight: their dialect is JSON Schema 2020-12 + the OAS vocabulary, which needs `$dynamicRef`/`$dynamicAnchor` resolution, `$ref`-sibling composition and `unevaluated*` applicators — machinery JSONSchema-Core doesn't have yet. A 3.1 meta-schema builds but degrades to accepting anything, since it can't yet enforce the 2020-12 keywords.
- **`allOf` composition of object schemas** (the common "extends" pattern, e.g. `Pet = allOf[NewPet, {id}]`) merges properties/required/additionalProperties for reading. A mixed/primitive `allOf` (not every branch object-shaped) has no sensible single merge target and stays a raw passthrough.
- **A schema derived purely from `allOf`** (no explicit `type` keyword of its own) can't re-serialize its `type` keyword through `specString` — a real gap, not silently wrong: it raises rather than guessing.
- **`OpenAPI-REST`** (server-side routing) is effectively unmaintained legacy code: excluding test-infrastructure changes, the entire package has had exactly one commit (the initial import) in the repository's history.
- Only **local `$ref`s** are resolved (inherited from JSONSchema-Core — no remote/external reference fetching).

If you need something that is missing you are welcome to open a pull request, or a ticket in this repository.
