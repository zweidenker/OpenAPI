accessing
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( title required ).
		(mapping mapInstVar: #properties) valueSchema: #PropertiesDictionary.
		(mapping mapInstVar: #items) valueSchema: #Items.
		"mapping mapAccessors: #( multipleOf maximum exclusiveMaximum minimum exclusiveMinimum maxLength minLength pattern maxItems minItems uniqueItems maxProperties minProperties enum )."
		"mapping mapAccessors: #( allOf oneOf anyOf not items additionalProperties description  )."
		 ].
	mapper for: #Items customDo: [ :mapping |
		mapping valueOrReferenceSchema: OASchema ].
	mapper for: #PropertiesDictionary customDo: [ :mapping |
		mapping mapWithValueSchema: OASchema ].