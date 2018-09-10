tests
testParseExample1
	| schema |
	schema := JSONSchema fromString: self exampleSchema1.
	schema validate: (NeoJSONReader fromString: self exampleData1)