Class {
	#name : 'OADocumentValidatorTests',
	#superclass : 'TestCase',
	#category : 'OpenAPI-Core-Tests',
	#package : 'OpenAPI-Core-Tests'
}

{ #category : 'tests' }
OADocumentValidatorTests >> testApiKeySecuritySchemeIsValid [
	self assert: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{},"components":{"securitySchemes":{"apiKeyAuth":{"type":"apiKey","name":"X-API-Key","in":"header"}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testBadPathsTypeIsInvalid [
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":"nope"}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testComponentSchemaAdditionalPropertiesBooleanFalseIsValid [
	self assert: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{},"components":{"schemas":{"Foo":{"type":"object","additionalProperties":false}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testComponentSchemaAdditionalPropertiesInvalidTypeIsInvalid [
	"additionalProperties must be a Schema, a Reference, or a boolean - a plain string is none of those."
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{},"components":{"schemas":{"Foo":{"type":"object","additionalProperties":"nope"}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testComponentSchemaAdditionalPropertiesSchemaObjectIsValid [
	self assert: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{},"components":{"schemas":{"Foo":{"type":"object","additionalProperties":{"type":"string"}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testCookieParameterIsValid [
	self assert: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo":{"get":{"parameters":[{"name":"c","in":"cookie","schema":{"type":"string"}}],"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testExplicitVersion30 [
	self shouldnt: [ OADocumentValidator validateDocument: self validMinimalDocument version: '3.0.3' ] raise: Error
]

{ #category : 'tests' }
OADocumentValidatorTests >> testHeaderParameterIsValid [
	self assert: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo":{"get":{"parameters":[{"name":"h","in":"header","schema":{"type":"string"}}],"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testHttpBearerSecuritySchemeIsValid [
	self assert: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{},"components":{"securitySchemes":{"bearerAuth":{"type":"http","scheme":"bearer","bearerFormat":"JWT"}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testHttpSchemeWithBearerFormatOnNonBearerSchemeIsInvalid [
	"bearerFormat is only meaningful (and only allowed by the meta-schema) when scheme:bearer."
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{},"components":{"securitySchemes":{"basicAuth":{"type":"http","scheme":"basic","bearerFormat":"JWT"}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testMissingInfoIsInvalid [
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","paths":{}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testMissingOpenapiVersionRaises [
	self should: [ OADocumentValidator validateDocument: '{"info":{"title":"t","version":"1"},"paths":{}}' ] raise: Error
]

{ #category : 'tests' }
OADocumentValidatorTests >> testMissingPathsIsInvalid [
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testOAuth2SecuritySchemeMissingFlowsIsInvalid [
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{},"components":{"securitySchemes":{"oauth":{"type":"oauth2"}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testParameterWithBothExampleAndExamplesIsInvalid [
	"ExampleXORExamples: example and examples are mutually exclusive."
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo":{"get":{"parameters":[{"name":"q","in":"query","schema":{"type":"string"},"example":"a","examples":{"x":{"value":"a"}}}],"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testParameterWithBothSchemaAndContentIsInvalid [
	"SchemaXORContent: schema and content are mutually exclusive, exactly one is required."
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo":{"get":{"parameters":[{"name":"q","in":"query","schema":{"type":"string"},"content":{"application/json":{}}}],"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testParameterWithContentAndStyleIsInvalid [
	"When content is used instead of schema, style/explode/allowReserved/example/examples are disallowed."
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo":{"get":{"parameters":[{"name":"q","in":"query","content":{"application/json":{}},"style":"form"}],"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testParameterWithNeitherSchemaNorContentIsInvalid [
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo":{"get":{"parameters":[{"name":"q","in":"query"}],"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testParameterWithOnlyContentIsValid [
	self assert: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo":{"get":{"parameters":[{"name":"q","in":"query","content":{"application/json":{}}}],"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testParameterWithOnlyExampleIsValid [
	self assert: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo":{"get":{"parameters":[{"name":"q","in":"query","schema":{"type":"string"},"example":"a"}],"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testParameterWithSwagger2StyleBodyLocationIsInvalid [
	"in: body is Swagger 2.0, not OpenAPI 3.0 (body moved to requestBody) - matches none of the oneOf location branches."
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo":{"get":{"parameters":[{"name":"q","in":"body","schema":{"type":"string"}}],"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testPathNotStartingWithSlashIsInvalid [
	"Paths keys must match ^\/ (or the ^x- vendor-extension pattern); anything else is rejected by additionalProperties:false."
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"foo":{"get":{"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testPathParameterMissingRequiredIsInvalid [
	"PathParameter in the OAI meta-schema mandates required:true - a path parameter without it does not match any of the Parameter oneOf branches (path/query/header/cookie)."
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo/{id}":{"get":{"parameters":[{"name":"id","in":"path","schema":{"type":"string"}}],"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testPathParameterWithRequiredTrueIsValid [
	self assert: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo/{id}":{"get":{"parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string"}}],"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testPathWithVendorExtensionIsValid [
	self assert: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo":{"get":{"responses":{"200":{"description":"ok"}}}},"x-internal-note":"draft"}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testQueryParameterOptionalIsValid [
	self assert: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo":{"get":{"parameters":[{"name":"q","in":"query","schema":{"type":"string"}}],"responses":{"200":{"description":"ok"}}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testResponsesObjectRequiresAtLeastOneEntry [
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":{"/foo":{"get":{"responses":{}}}}}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testSchemaForVersionIsCachedAcrossPatchVersions [
	OADocumentValidator resetSchemaCache.
	self assert: (OADocumentValidator schemaForVersion: '3.0.0') == (OADocumentValidator schemaForVersion: '3.0.3')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testValidMinimalDocumentIsValid [
	self assert: (OADocumentValidator isValidDocument: self validMinimalDocument)
]

{ #category : 'tests' }
OADocumentValidatorTests >> testValidateReturnsParsedDocument [
	| doc |
	doc := OADocumentValidator validateDocument: self validMinimalDocument.
	self assert: (doc at: 'openapi') equals: '3.0.0'.
	self assert: ((doc at: 'info') at: 'title') equals: 'Test API'
]

{ #category : 'tests' }
OADocumentValidatorTests >> testValidationErrorForBadPathsTypeIsJSONSchemaError [
	| error |
	error := OADocumentValidator validationErrorFor: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":"nope"}'.
	self assert: (error isKindOf: JSONSchemaError)
]

{ #category : 'tests' }
OADocumentValidatorTests >> testValidationErrorForValidDocumentIsNil [
	self assert: (OADocumentValidator validationErrorFor: self validMinimalDocument) isNil
]

{ #category : 'tests' }
OADocumentValidatorTests >> testValidationErrorMessageForBadPathsTypeDescribesFailure [
	| message |
	message := OADocumentValidator validationErrorMessageFor: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":"nope"}'.
	self assert: (message includesSubstring: 'JSONTypeError').
	self assert: (message includesSubstring: 'not an object')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testValidationErrorMessageForMissingInfoDescribesFailure [
	| message |
	message := OADocumentValidator validationErrorMessageFor: '{"openapi":"3.0.0","paths":{}}'.
	self assert: (message includesSubstring: 'JSONSchemaMissingRequiredProperty')
]

{ #category : 'fixtures' }
OADocumentValidatorTests >> validMinimalDocument [
	^ '{"openapi":"3.0.0","info":{"title":"Test API","version":"1.0.0"},"paths":{}}'
]
