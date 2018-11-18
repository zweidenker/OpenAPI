as yet unclassified
visitOpenApi: anApi
| visitor |
	visitor := JSONSchemaReferenceResolveVisitor new
			schemaRepository: self.
	anApi components schemas: (anApi components schemas collect: #asJSONSchema).
	anApi components schemas: (anApi components schemas collect: [ :definition |
		 visitor read: definition ]).
	^ super visitOpenApi: anApi