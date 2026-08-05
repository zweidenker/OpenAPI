Class {
	#name : 'OARequestBuilderTest',
	#superclass : 'TestCase',
	#category : 'OpenAPI-Client-Tests-Tests',
	#package : 'OpenAPI-Client-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
OARequestBuilderTest >> testAddCookieParameterAccumulatesIntoCookieHeader [
	| client builder |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	builder addCookieParameter: 'session' value: 'abc'.
	builder addCookieParameter: 'theme' value: 'dark'.
	self assert: (client request headers at: 'Cookie') equals: 'session=abc; theme=dark'
]

{ #category : 'tests' }
OARequestBuilderTest >> testAddFormBodyBuildsFormUrlEncodedEntity [
	| client builder entity |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	builder addFormBody: (Dictionary new at: 'email' put: 'test@example.com'; yourself).
	entity := client request entity.
	self assert: entity contentType sub equals: 'x-www-form-urlencoded'.
	self assert: (entity contents at: 'email') equals: 'test@example.com'
]

{ #category : 'tests' }
OARequestBuilderTest >> testAddHeaderParameterSetsRequestHeader [
	"OAHeaderParametersLocation and OACookieParameterLocation used to have no
	#write:value:to: method at all - writing any header or cookie parameter into a
	real request via OAParameter>>copyFrom:to: crashed with #doesNotUnderstand."
	| client builder |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	builder addHeaderParameter: 'X-Api-Key' value: 'secret123'.
	self assert: (client request headers at: 'X-Api-Key') equals: 'secret123'
]

{ #category : 'tests' }
OARequestBuilderTest >> testCookieParameterArrayValueCommaJoins [
	"Regression: cookie write:value:to: used to send #asString to the raw value - an
	Array printed as garbage instead of a comma-joined string. Unlike query parameters,
	a single Cookie header cannot repeat the same name for form+explode:true arrays, so
	this is deliberately comma-joined rather than left as separate repeated pairs."
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'ids'; in: #cookie; required: true;
		schema: (JSONSchemaArray new items: JSONSchema integer); yourself.
	dict := Dictionary new at: 'ids' put: #(1 2); yourself.
	param copyFrom: dict to: builder.
	self assert: (client request headers at: 'Cookie') equals: 'ids=1,2'
]

{ #category : 'tests' }
OARequestBuilderTest >> testCookieParameterWrittenViaParameterCopyFromTo [
	| param builder client dict |
	client := ZnClient new.
	param := OAParameter new name: 'session'; in: #cookie; required: true; schema: JSONSchema string; yourself.
	builder := OARequestBuilder new client: client.
	dict := Dictionary new at: 'session' put: 'abc'; yourself.
	param copyFrom: dict to: builder.
	self assert: (client request headers at: 'Cookie') equals: 'session=abc'
]

{ #category : 'tests' }
OARequestBuilderTest >> testFlattenArrayOfObjects [
	| builder result items |
	items := OrderedCollection new
		add: (Dictionary new at: 'price' put: 'price_abc'; at: 'quantity' put: '1'; yourself);
		yourself.
	builder := OARequestBuilder new.
	result := builder flattenFormParameters: (Dictionary new at: 'items' put: items; yourself).
	self assert: (result at: 'items[0][price]') equals: 'price_abc'.
	self assert: (result at: 'items[0][quantity]') equals: '1'
]

{ #category : 'tests' }
OARequestBuilderTest >> testFlattenDeeplyNestedObject [
	| builder result nested |
	nested := Dictionary new
		at: 'end_behavior' put: (Dictionary new at: 'missing_payment_method' put: 'cancel'; yourself);
		yourself.
	builder := OARequestBuilder new.
	result := builder flattenFormParameters: (Dictionary new at: 'trial_settings' put: nested; yourself).
	self assert: (result at: 'trial_settings[end_behavior][missing_payment_method]') equals: 'cancel'
]

{ #category : 'tests' }
OARequestBuilderTest >> testFlattenNestedDictionary [
	| builder result |
	builder := OARequestBuilder new.
	result := builder flattenFormParameters: (Dictionary new
		at: 'metadata' put: (Dictionary new at: 'apptiveid' put: 'acc_42'; yourself);
		yourself).
	self assert: (result at: 'metadata[apptiveid]') equals: 'acc_42'
]

{ #category : 'tests' }
OARequestBuilderTest >> testFlattenNestedOrderedDictionary [
	"NeoJSON-produced objects (NeoJSONObject/OrderedDictionary) must flatten the
	same way as plain Dictionary - this is what schema-validated request bodies
	actually are, not a hand-built Dictionary."
	| builder result neoObject |
	neoObject := NeoJSONObject new.
	neoObject at: 'apptiveid' put: 'acc_42'.
	builder := OARequestBuilder new.
	result := builder flattenFormParameters: (Dictionary new
		at: 'metadata' put: neoObject;
		yourself).
	self assert: (result at: 'metadata[apptiveid]') equals: 'acc_42'
]

{ #category : 'tests' }
OARequestBuilderTest >> testFlattenScalarValues [
	| builder result |
	builder := OARequestBuilder new.
	result := builder flattenFormParameters: (Dictionary new
		at: 'customer' put: 'cus_123';
		at: 'trial_end' put: 'now';
		yourself).
	self assert: (result at: 'customer') equals: 'cus_123'.
	self assert: (result at: 'trial_end') equals: 'now'
]

{ #category : 'tests' }
OARequestBuilderTest >> testHeaderParameterArrayValueCommaJoins [
	"Regression: header write:value:to: used to send #asString to the raw value -
	an Array printed as garbage (e.g. #(3 4 5)) instead of a comma-joined string."
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'X-Ids'; in: #header; required: true;
		schema: (JSONSchemaArray new items: JSONSchema integer); yourself.
	dict := Dictionary new at: 'X-Ids' put: #(3 4 5); yourself.
	param copyFrom: dict to: builder.
	self assert: (client request headers at: 'X-Ids') equals: '3,4,5'
]

{ #category : 'tests' }
OARequestBuilderTest >> testHeaderParameterWrittenViaParameterCopyFromTo [
	"End-to-end: a header OAParameter must be writable via the same
	#copyFrom:to: path OAOperation>>applyParameters:builder: actually uses."
	| param builder client dict |
	client := ZnClient new.
	param := OAParameter new name: 'X-Api-Key'; in: #header; required: true; schema: JSONSchema string; yourself.
	builder := OARequestBuilder new client: client.
	dict := Dictionary new at: 'X-Api-Key' put: 'secret123'; yourself.
	param copyFrom: dict to: builder.
	self assert: (client request headers at: 'X-Api-Key') equals: 'secret123'
]

{ #category : 'tests' }
OARequestBuilderTest >> testPathParameterIntegerValueDoesNotCrash [
	"Regression: addPathSegments: requires Strings: a bare Integer path parameter value
	used to crash the whole request build with #doesNotUnderstand: #readStream."
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'id'; in: #path; required: true; schema: JSONSchema integer; yourself.
	dict := Dictionary new at: 'id' put: 5; yourself.
	param copyFrom: dict to: builder.
	builder path: '/pets/{id}'; baseUri: (ZnUrl new scheme: #http; host: 'x').
	self shouldnt: [ builder buildClient ] raise: Error.
	self assert: client request url pathPrintString equals: '/pets/5'
]

{ #category : 'tests' }
OARequestBuilderTest >> testPathParameterLabelStyleArrayExplodeTrue [
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'id'; in: #path; required: true; style: 'label'; explode: true;
		schema: (JSONSchemaArray new items: JSONSchema string); yourself.
	dict := Dictionary new at: 'id' put: #('blue' 'black' 'brown'); yourself.
	param copyFrom: dict to: builder.
	builder path: '/colors/{id}'; baseUri: (ZnUrl new scheme: #http; host: 'x').
	builder buildClient.
	self assert: client request url pathPrintString equals: '/colors/.blue.black.brown'
]

{ #category : 'tests' }
OARequestBuilderTest >> testPathParameterMatrixStyleArrayExplodeFalse [
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'id'; in: #path; required: true; style: 'matrix'; explode: false;
		schema: (JSONSchemaArray new items: JSONSchema integer); yourself.
	dict := Dictionary new at: 'id' put: #(3 4 5); yourself.
	param copyFrom: dict to: builder.
	builder path: '/pets/{id}'; baseUri: (ZnUrl new scheme: #http; host: 'x').
	builder buildClient.
	self assert: client request url pathPrintString equals: '/pets/;id=3,4,5'
]

{ #category : 'tests' }
OARequestBuilderTest >> testPathParameterMatrixStyleArrayExplodeTrue [
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'id'; in: #path; required: true; style: 'matrix'; explode: true;
		schema: (JSONSchemaArray new items: JSONSchema integer); yourself.
	dict := Dictionary new at: 'id' put: #(3 4 5); yourself.
	param copyFrom: dict to: builder.
	builder path: '/pets/{id}'; baseUri: (ZnUrl new scheme: #http; host: 'x').
	builder buildClient.
	self assert: client request url pathPrintString equals: '/pets/;id=3;id=4;id=5'
]

{ #category : 'tests' }
OARequestBuilderTest >> testPathParameterSimpleStyleArrayIsUnaffectedByExplode [
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'id'; in: #path; required: true;
		schema: (JSONSchemaArray new items: JSONSchema string); yourself.
	dict := Dictionary new at: 'id' put: #('blue' 'black' 'brown'); yourself.
	param copyFrom: dict to: builder.
	builder path: '/colors/{id}'; baseUri: (ZnUrl new scheme: #http; host: 'x').
	builder buildClient.
	self assert: client request url pathPrintString equals: '/colors/blue,black,brown'
]

{ #category : 'tests' }
OARequestBuilderTest >> testQueryParameterDeepObjectStyle [
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'id'; in: #query; required: false; style: 'deepObject'; yourself.
	dict := Dictionary new at: 'id' put: (Dictionary new at: #role put: 'admin'; yourself); yourself.
	param copyFrom: dict to: builder.
	builder path: '/pets'; baseUri: (ZnUrl new scheme: #http; host: 'x').
	builder buildClient.
	self assert: client request url printString equals: 'http://x:80/pets?id%5Brole%5D=admin'
]

{ #category : 'tests' }
OARequestBuilderTest >> testQueryParameterFormStyleArrayExplodeFalseCommaJoins [
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'tags'; in: #query; required: false; explode: false;
		schema: (JSONSchemaArray new items: JSONSchema string); yourself.
	dict := Dictionary new at: 'tags' put: #('a' 'b' 'c'); yourself.
	param copyFrom: dict to: builder.
	builder path: '/pets'; baseUri: (ZnUrl new scheme: #http; host: 'x').
	builder buildClient.
	self assert: client request url printString equals: 'http://x:80/pets?tags=a,b,c'
]

{ #category : 'tests' }
OARequestBuilderTest >> testQueryParameterFormStyleArrayExplodeTrueDefaultRepeatsKey [
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'tags'; in: #query; required: false;
		schema: (JSONSchemaArray new items: JSONSchema string); yourself.
	dict := Dictionary new at: 'tags' put: #('a' 'b' 'c'); yourself.
	param copyFrom: dict to: builder.
	builder path: '/pets'; baseUri: (ZnUrl new scheme: #http; host: 'x').
	builder buildClient.
	self assert: client request url printString equals: 'http://x:80/pets?tags=a&tags=b&tags=c'
]

{ #category : 'tests' }
OARequestBuilderTest >> testQueryParameterFormStyleObjectExplodeFalseCommaFlattens [
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'id'; in: #query; required: false; explode: false; yourself.
	dict := Dictionary new at: 'id' put: (Dictionary new at: #role put: 'admin'; yourself); yourself.
	param copyFrom: dict to: builder.
	builder path: '/pets'; baseUri: (ZnUrl new scheme: #http; host: 'x').
	builder buildClient.
	self assert: client request url printString equals: 'http://x:80/pets?id=role,admin'
]

{ #category : 'tests' }
OARequestBuilderTest >> testQueryParameterFormStyleObjectExplodeTrueDefaultFlattensProperties [
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'id'; in: #query; required: false; yourself.
	dict := Dictionary new at: 'id' put: (Dictionary new at: #role put: 'admin'; yourself); yourself.
	param copyFrom: dict to: builder.
	builder path: '/pets'; baseUri: (ZnUrl new scheme: #http; host: 'x').
	builder buildClient.
	self assert: client request url printString equals: 'http://x:80/pets?role=admin'
]

{ #category : 'tests' }
OARequestBuilderTest >> testQueryParameterPipeDelimitedStyle [
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'tags'; in: #query; required: false; style: 'pipeDelimited';
		schema: (JSONSchemaArray new items: JSONSchema string); yourself.
	dict := Dictionary new at: 'tags' put: #('a' 'b' 'c'); yourself.
	param copyFrom: dict to: builder.
	builder path: '/pets'; baseUri: (ZnUrl new scheme: #http; host: 'x').
	builder buildClient.
	self assert: client request url printString equals: 'http://x:80/pets?tags=a%7Cb%7Cc'
]

{ #category : 'tests' }
OARequestBuilderTest >> testQueryParameterSpaceDelimitedStyle [
	| client builder param dict |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	param := OAParameter new name: 'tags'; in: #query; required: false; style: 'spaceDelimited';
		schema: (JSONSchemaArray new items: JSONSchema string); yourself.
	dict := Dictionary new at: 'tags' put: #('a' 'b' 'c'); yourself.
	param copyFrom: dict to: builder.
	builder path: '/pets'; baseUri: (ZnUrl new scheme: #http; host: 'x').
	builder buildClient.
	self assert: client request url printString equals: 'http://x:80/pets?tags=a%20b%20c'
]

{ #category : 'tests' }
OARequestBuilderTest >> testWriteBodyWithAllOfComposedSchemaDoesNotCrash [
	"allOf-composed schemas (no direct type/properties keyword, like petstoreExpanded's
	Pet = allOf[NewPet, {id}]) resolve to JSONSchemaAnyObject via #asJSONSchema since
	nothing sets schemaClass for a bare allOf. Writing a body against such a schema
	must degrade to a plain passthrough rather than crash."
	| definition schema mediaType client builder body |
	definition := JSONSchemaDefinition new
		allOf: { JSONSchemaDefinition new
			properties: { 'name' -> (JSONSchemaDefinition new typeString: 'string'; yourself) } asDictionary;
			yourself };
		yourself.
	schema := definition asJSONSchema.
	self assert: schema class equals: JSONSchemaAnyObject.
	mediaType := OAMediaTypeObject new schema: schema.
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	body := Dictionary new at: 'name' put: 'Rex'; yourself.
	mediaType writeBody: body builder: builder.
	self assert: client request entity contents equals: '{"name":"Rex"}'
]

{ #category : 'tests' }
OARequestBuilderTest >> testWriteBodyWithNonObjectSchemaDoesNotCrash [
	"Regression test: OAMediaTypeObject>>writeBody:builder: used to send #isAnyObject
	unconditionally to the body schema. #isAnyObject is only implemented on
	JSONSchemaObject, so any non-object body schema (bare string, array, or an
	allOf-composed schema which resolves to JSONSchemaAnyObject) crashed with
	#doesNotUnderstand: #isAnyObject when building a real request."
	| mediaType client builder |
	mediaType := OAMediaTypeObject new schema: JSONSchema string.
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	mediaType writeBody: 'hello world' builder: builder.
	self assert: client request entity contents equals: '"hello world"'
]

{ #category : 'tests' }
OARequestBuilderTest >> testWriteFormBodyWithAllOfComposedSchemaDoesNotCrash [
	"Same passthrough bug as #writeBody:builder: (both send #isAnyObject
	unconditionally), but for the x-www-form-urlencoded path. An allOf-composed
	body schema resolves to JSONSchemaAnyObject and must still form-encode."
	| definition schema mediaType client builder body |
	definition := JSONSchemaDefinition new
		allOf: { JSONSchemaDefinition new
			properties: { 'name' -> (JSONSchemaDefinition new typeString: 'string'; yourself) } asDictionary;
			yourself };
		yourself.
	schema := definition asJSONSchema.
	self assert: schema class equals: JSONSchemaAnyObject.
	mediaType := OAMediaTypeObject new schema: schema.
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	body := Dictionary new at: 'name' put: 'Rex'; yourself.
	mediaType writeFormBody: body builder: builder.
	self assert: client request entity contentType sub equals: 'x-www-form-urlencoded'.
	self assert: (client request entity contents at: 'name') equals: 'Rex'
]
