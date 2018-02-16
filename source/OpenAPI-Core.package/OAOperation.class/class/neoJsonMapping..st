instance creation
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( tags summary description externalDocs operationId responses callbacks deprecated security servers).
		(mapping mapInstVar: #parameters) valueSchema: #ParameterList.
		(mapping mapInstVar: #requestBody) valueSchema: OARequestBody.
		 ].
	mapper for: #ParameterList customDo: [ :mapping |
		mapping listOfElementSchema: OAParameter ]