accessing
neoJsonMapping: mapper
	mapper
		for: self
		do: [ :mapping | 
			mapping mapInstVars: #(description).
			(mapping mapInstVar: #headers) valueSchema: #HeaderDictionary.
			(mapping mapInstVar: #content) valueSchema: #ContentDictionary.
			(mapping mapInstVar: #links) valueSchema: #LinkDictionary. ].
	mapper
		for: #HeaderDictionary customDo: [ :mapping | mapping mapWithValueSchema: OAHeader. ];
		for: #ContentDictionary customDo: [ :mapping | mapping mapWithValueSchema: OAMediaTypeObject. ];
		for: #LinkDictionary customDo: [ :mapping | mapping mapWithValueSchema: OALink. ].