instance creation
neoJsonMapping: mapper
	super neoJsonMapping: mapper.
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( default )  ]