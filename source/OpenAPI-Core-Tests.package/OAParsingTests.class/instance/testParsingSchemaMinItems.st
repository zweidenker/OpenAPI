tests
testParsingSchemaMinItems
	| schemaDefinition |
	schemaDefinition := NeoJSONReader fromString: self schemaArrayMinItems as: OASchemaDefinition.
	self assert: schemaDefinition schemaClass equals: JSONSchemaArray 