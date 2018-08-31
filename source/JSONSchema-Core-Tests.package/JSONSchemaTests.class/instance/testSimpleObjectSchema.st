tests
testSimpleObjectSchema
	| schema object |
	schema := JSONSchema new 
		typeString: 'object';
		properties: { 
			#foo -> JSONSchema string.
			#bar -> JSONSchema integer } asDictionary.
	object := schema readFrom: (NeoJSONReader fromString: '{ "foo" : "123", "bar" : 123 }').
	self assert: object foo equals: '123'.
	self assert: object bar equals: 123