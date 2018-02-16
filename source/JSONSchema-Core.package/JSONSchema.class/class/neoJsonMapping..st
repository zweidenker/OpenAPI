accessing
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( title required properties ).
		(mapping mapInstVar: #items) valueSchema: #Items.
		"mapping mapAccessors: #( multipleOf maximum exclusiveMaximum minimum exclusiveMinimum maxLength minLength pattern maxItems minItems uniqueItems maxProperties minProperties enum )."
		"mapping mapAccessors: #( allOf oneOf anyOf not items additionalProperties description  )."
		 ].
	mapper for: #Items customDo: [ :mapping |
		mapping valueOrReferenceSchema: OASchema ].