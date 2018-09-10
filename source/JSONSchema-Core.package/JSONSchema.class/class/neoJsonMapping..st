accessing
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( title ).
		mapping mapAccessors: #( required ).
		(mapping mapAccessor: #properties) valueSchema: #PropertiesDictionary.
		(mapping mapAccessor: #items) valueSchema: #Items.
		"mapping mapAccessors: #( multipleOf maximum exclusiveMaximum minimum exclusiveMinimum maxLength minLength pattern maxItems minItems uniqueItems maxProperties minProperties enum )."
		(mapping mapAccessor: #allOf) valueSchema: #SchemaList.
		"mapping mapAccessors: #( oneOf anyOf not items additionalProperties description  )."
		mapping mapAccessor: #typeString mutator: #typeString: to: #type.
		 ].
	mapper for: #Items customDo: [ :mapping |
		mapping valueOrReferenceSchema: JSONSchema ].
	mapper for: #PropertiesDictionary customDo: [ :mapping |
		mapping mapWithValueSchema: #SchemaOrReference ].
	mapper for: #SchemaOrReference customDo: [ :mapping |
		mapping  valueOrReferenceSchema: JSONSchema ].
	mapper for: #SchemaList customDo: [ :mapping |
		mapping listOfElementSchema: #SchemaOrReference. ]