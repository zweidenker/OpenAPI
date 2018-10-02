as yet unclassified
processSchema: anOASchemaDefinition 
	^ JSONSchemaReferenceResolveVisitor new
		resolver: self;
		read: anOASchemaDefinition 