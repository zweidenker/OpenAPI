instance creation
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( title description termsOfService version ).
		(mapping mapInstVar: #contact) valueSchema: OAContact.
		(mapping mapInstVar: #license) valueSchema: OALicense ]