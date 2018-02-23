accessing
neoJsonMapping: mapper
	mapper for: self do: [ :mapping | (mapping mapInstVar: #responses) valueSchema: #ResponseDictionary. ].
	mapper for: #ResponseDictionary customDo: [ :mapping | mapping listOfElementSchema: OAResponse. ].