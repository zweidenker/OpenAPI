visting
visitSchemaDefinition: aSchema 
	^ JSONSchemaVisitor new
		visit: aSchema;
		schema