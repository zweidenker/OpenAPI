tests
testParsingSchemaSimple
	| schema string |
	schema := NeoJSONReader fromString: self schemaSimpleString as: OASchema.
	self assert: schema type equals: OATypeObject 