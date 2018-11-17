as yet unclassified
processSchema: anOASchemaDefinition 
	^ JSONSchemaReferenceResolveVisitor new
		schemaRepository: self;
		read: anOASchemaDefinition 