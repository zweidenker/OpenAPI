instance creation
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( tags summary description externalDocs operationId  requestBody responses callbacks deprecated security servers).
		(mapping mapInstVar: #parameters) valueSchema: #ParameterList.
		 ].
	mapper for: #ParameterList customDo: [ :mapping |
		mapping listOfElementSchema: OAParameter ]