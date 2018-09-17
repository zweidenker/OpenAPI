as yet unclassified
visitJSONSchema: aSchema 
	^ JSONSchemaReferenceResolveVisitor new
		resolver: self;
		read: aSchema