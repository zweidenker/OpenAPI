Class {
	#name : 'OAExampleDocumentsTests',
	#superclass : 'TestCase',
	#category : 'OpenAPI-Core-Tests',
	#package : 'OpenAPI-Core-Tests'
}

{ #category : 'tests' }
OAExampleDocumentsTests >> testAllBundledExamplesRoundTripExceptUspto [
	"Broader than validity: confirms OpenAPI fromString:/specString handle every bundled
	official example without raising, except uspto (see #testUsptoRoundTripFailsOnSchemaTypeSerialization
	for the known, not-yet-fixed gap)."
	#(petstore petstoreExpanded apiWithExamples callbackExample linkExample) do: [ :selector |
		| api |
		self shouldnt: [ api := OpenAPI fromString: (OAExampleDocuments perform: selector) ] raise: Error.
		self shouldnt: [ api specString ] raise: Error ]
]

{ #category : 'tests' }
OAExampleDocumentsTests >> testApiWithExamplesIsValid [
	self assert: (OADocumentValidator isValidDocument: OAExampleDocuments apiWithExamples)
]

{ #category : 'tests' }
OAExampleDocumentsTests >> testCallbackExampleIsValid [
	self assert: (OADocumentValidator isValidDocument: OAExampleDocuments callbackExample)
]

{ #category : 'tests' }
OAExampleDocumentsTests >> testLinkExampleIsValid [
	self assert: (OADocumentValidator isValidDocument: OAExampleDocuments linkExample)
]

{ #category : 'tests' }
OAExampleDocumentsTests >> testPetstoreExpandedIsValid [
	self assert: (OADocumentValidator isValidDocument: OAExampleDocuments petstoreExpanded)
]

{ #category : 'tests' }
OAExampleDocumentsTests >> testPetstoreIsValid [
	self assert: (OADocumentValidator isValidDocument: OAExampleDocuments petstore)
]

{ #category : 'tests' }
OAExampleDocumentsTests >> testUsptoIsValid [
	self assert: (OADocumentValidator isValidDocument: OAExampleDocuments uspto)
]

{ #category : 'tests' }
OAExampleDocumentsTests >> testUsptoRoundTripFailsOnSchemaTypeSerialization [
	"Known gap, not fixed here: JSONSchemaDefinition has typeString: (reader) but no
	typeString (writer) accessor, so specString cannot re-serialize a schema's type keyword.
	Deliberately not fixed in this pass - schemaClass defaults to JSONSchemaAnyObject even
	when no type: was ever specified, so a naive typeString getter would wrongly inject
	type:any into schemas that never had a type keyword. A correct fix needs to track
	whether type was explicitly specified (the same pattern already used for #const /
	#constSpecified) before it can round-trip safely."
	| api |
	api := OpenAPI fromString: OAExampleDocuments uspto.
	self should: [ api specString ] raise: MessageNotUnderstood
]
