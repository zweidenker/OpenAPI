Class {
	#name : 'OADocumentValidatorTests',
	#superclass : 'TestCase',
	#category : 'OpenAPI-Core-Tests',
	#package : 'OpenAPI-Core-Tests'
}

{ #category : 'tests' }
OADocumentValidatorTests >> testBadPathsTypeIsInvalid [
	self deny: (OADocumentValidator isValidDocument: '{"openapi":"3.0.0","info":{"title":"t","version":"1"},"paths":"nope"}')
]

{ #category : 'tests' }
OADocumentValidatorTests >> testExplicitVersion30 [
	self shouldnt: [ OADocumentValidator validateDocument: self validMinimalDocument version: '3.0.3' ] raise: Error
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
