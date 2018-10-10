accessing
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapAccessors: #( parameters examples requestBodies headers securitySchemes links callbacks ).
		(mapping mapAccessor: #schemas) valueSchema: #OASchemas.
		(mapping mapInstVar: #parameters) valueSchema: #Parameters.
		self flag: #todo.
		"Response object needs to be done. https://github.com/zweidenker/OpenAPI/issues/3"
		(mapping mapAccessor: #responses) "valueSchema: #OAResponses".
		"(mapping mapAccessor: #example) valueSchema: OAExample."
		(mapping mapAccessor: #examples) valueSchema: #OAExamples ].
	mapper for: #OASchemas customDo: [ :mapping |
		mapping  mapWithValueSchema: OASchemaDefinition ].  
	mapper for: #OAExamples customDo: [ :mapping |
		mapping  mapWithValueSchema: OAExample ].  
	mapper for: #Parameters customDo: [ :mapping |
		mapping mapWithValueSchema: OAParameter ]