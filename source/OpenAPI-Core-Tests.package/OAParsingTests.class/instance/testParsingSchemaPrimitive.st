tests
testParsingSchemaPrimitive
	| schema |
	schema := NeoJSONReader fromString: self schemaPrimitiveString as: OASchema.
	self assert: schema type class equals: JSONTypeString .
	self assert: schema format equals: JSONFormatEmail . 
	