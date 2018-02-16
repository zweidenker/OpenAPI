instance creation
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapAccessors: #( openapi servers security tags externalDocs ).
		(mapping mapAccessor: #info) valueSchema: OAInfo.
		(mapping mapAccessor: #paths) valueSchema: #OAPaths.
		(mapping mapAccessor: #components) valueSchema: OAComponents ].
	mapper for: #OAPaths customDo: [ :mapping |
		mapping  mapWithValueSchema: OAPathItem ]