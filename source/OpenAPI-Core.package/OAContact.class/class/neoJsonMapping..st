instance creation
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( name url email ) ]