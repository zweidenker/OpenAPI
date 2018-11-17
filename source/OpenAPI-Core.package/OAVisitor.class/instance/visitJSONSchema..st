as yet unclassified
visitJSONSchema: aSchema 
	^ JSONSchemaReferenceResolveVisitor new
		schemaRepository: self;
		read: aSchema