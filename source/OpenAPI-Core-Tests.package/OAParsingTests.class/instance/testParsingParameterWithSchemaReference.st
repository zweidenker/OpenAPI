tests
testParsingParameterWithSchemaReference
	| parameter |
	parameter := NeoJSONReader fromString: self parameterReferenceString as: OAParameter.
	self assert: parameter schema class = OASchema 