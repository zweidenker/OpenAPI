instance creation
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapInstVar: #path to: '$ref' ]