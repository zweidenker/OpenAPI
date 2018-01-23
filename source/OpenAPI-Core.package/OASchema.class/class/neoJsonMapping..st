instance creation
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( title required default properties ).
		mapping mapAccessor: #typeString mutator: #typeString: to: #type.
		mapping mapAccessor: #format mutator: #formatString: to: #format.
		"mapping mapAccessors: #( multipleOf maximum exclusiveMaximum minimum exclusiveMinimum maxLength minLength pattern maxItems minItems uniqueItems maxProperties minProperties enum )."
		"mapping mapAccessors: #( allOf oneOf anyOf not items additionalProperties description  )."
		 ].