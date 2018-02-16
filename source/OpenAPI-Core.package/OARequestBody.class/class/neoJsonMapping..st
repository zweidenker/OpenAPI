accessing
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( description required ).
		(mapping mapInstVar: #content) valueSchema: #MediaTypeObjects.
		 ].
	mapper for: #MediaTypeObjects customDo: [ :mapping |
		mapping mapWithValueSchema: OAMediaTypeObject ]