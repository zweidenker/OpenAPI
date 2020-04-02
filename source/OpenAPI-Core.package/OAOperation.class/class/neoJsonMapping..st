instance creation
neoJsonMapping: mapper
	mapper
		for: self
		do: [ :mapping | 
			mapping mapInstVars: #(tags summary description externalDocs operationId responses callbacks deprecated security servers).
			(mapping mapAccessor: #parametersSortedByName mutator: #parameters: to: #parameters) valueSchema: #ParameterList.
			(mapping mapInstVar: #requestBody) valueSchema: OARequestBody.
			(mapping mapAccessor: #responses) valueSchema: #ResponsesDictionary. ].
	mapper
		for: #ParameterList customDo: [ :mapping | mapping listOfElementSchema: OAParameter. ];
		for: #ResponsesDictionary customDo: [ :mapping | mapping mapWithValueSchema: OAResponse. ].