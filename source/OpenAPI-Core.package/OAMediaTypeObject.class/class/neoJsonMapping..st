accessing
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapAccessors: #( encoding ).
		(mapping mapAccessor: #schema) valueSchema: #SchemaOrReference.
		(mapping mapAccessor: #example) valueSchema: OAExample.
		(mapping mapAccessor: #examples) valueSchema: #OAExamples ].
	mapper for: #OAExamples customDo: [ :mapping |
		mapping  mapWithValueSchema: OAExample ].  
	mapper for: #SchemaOrReference customDo: [ :mapping |
		mapping  valueOrReferenceSchema: OASchema ].  
	