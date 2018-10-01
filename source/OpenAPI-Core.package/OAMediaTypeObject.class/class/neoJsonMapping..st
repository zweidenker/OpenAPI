accessing
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapAccessors: #( encoding ).
		(mapping mapAccessor: #schema) valueSchema: OASchemaDefinition.
		(mapping mapAccessor: #example) valueSchema: OAExample.
		(mapping mapAccessor: #examples) valueSchema: #OAExamples ].
	mapper for: #OAExamples customDo: [ :mapping |
		mapping  mapWithValueSchema: OAExample ]	