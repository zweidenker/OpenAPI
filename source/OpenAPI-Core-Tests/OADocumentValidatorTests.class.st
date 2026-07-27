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

{ #category : 'fixtures' }
OADocumentValidatorTests >> validMinimalDocument [
	^ '{"openapi":"3.0.0","info":{"title":"Test API","version":"1.0.0"},"paths":{}}'
]
