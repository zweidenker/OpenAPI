tests
testParsingSchemaPrimitive
	| schemaDefinition |
	schemaDefinition := NeoJSONReader fromString: self schemaPrimitiveString as: OASchemaDefinition.
	self assert: schemaDefinition schemaClass equals: JSONSchemaString.
	self assert: schemaDefinition format equals: JSONFormatEmail . 
	