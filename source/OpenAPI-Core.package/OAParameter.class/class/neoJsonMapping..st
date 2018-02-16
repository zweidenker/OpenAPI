instance creation
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( name in description required deprecated allowEmptyValue style explode allowReserved schema example examples content ).
		mapping mapAccessor: #in.
		(mapping mapInstVar: #schema) valueSchema: #SchemaOrReference. ].
	mapper for: #SchemaOrReference customDo: [ :mapping |
		mapping valueOrReferenceSchema: OASchema ].
