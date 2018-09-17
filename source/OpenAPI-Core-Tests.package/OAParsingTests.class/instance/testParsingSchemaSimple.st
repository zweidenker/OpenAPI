tests
testParsingSchemaSimple
	| schemaDefinition |
	schemaDefinition := NeoJSONReader fromString: self schemaSimpleString as: OASchema.
	self assert: schemaDefinition schemaClass equals: JSONSchemaObject 