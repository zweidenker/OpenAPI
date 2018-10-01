tests
testParsingSchemaSimple
	| schemaDefinition |
	schemaDefinition := NeoJSONReader fromString: self schemaSimpleString as: OASchemaDefinition.
	self assert: schemaDefinition schemaClass equals: JSONSchemaObject 