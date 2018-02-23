accessing
neoJsonMapping: mapper
	mapper
		for: self
		do: [ :mapping | 
			mapping mapInstVars: #(description).
			mapping mapInstVar: #headers.	" valueSchema: #HeadersDictionary"
			(mapping mapInstVar: #content) valueSchema: #ContentDictionary. ].
	mapper
		for: #HeadersDictionary customDo: [ :mapping | mapping mapWithValueSchema: OAHeader. ];
		for: #ContentDictionary
			customDo: [ :mapping | mapping mapWithValueSchema: OAMediaTypeObject. ].