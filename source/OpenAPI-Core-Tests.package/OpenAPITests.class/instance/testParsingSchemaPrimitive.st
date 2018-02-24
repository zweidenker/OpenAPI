tests
testParsingSchemaPrimitive
	| schema |
	schema := NeoJSONReader fromString: self schemaPrimitiveString as: OASchema.
	self assert: schema type equals: OATypeString .
	self assert: schema format equals: OAFormatEmail . 
	