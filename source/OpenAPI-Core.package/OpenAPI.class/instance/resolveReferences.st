as yet unclassified
resolveReferences
	^ OAReferenceResolveVisitor new 
		schemaRepository: self;
		resolve