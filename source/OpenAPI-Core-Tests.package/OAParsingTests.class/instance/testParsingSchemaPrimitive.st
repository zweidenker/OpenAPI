tests
testParsingSchemaPrimitive
	| schema |
	schema := NeoJSONReader fromString: self schemaPrimitiveString as: OASchema.
	self assert: schema type equals: JSONTypeString .
	self assert: schema format equals: JSONFormatEmail . 
	