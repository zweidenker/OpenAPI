tests
testParsingParameterWithSchemaObject
	| parameter |
	parameter := NeoJSONReader fromString: self parameterObjectString as: OAParameter.
	self assert: parameter description equals: 'token to be passed as a header'. 