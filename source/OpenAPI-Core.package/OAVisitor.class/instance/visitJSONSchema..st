as yet unclassified
visitJSONSchema: aSchema 
	^ JSONSchemaVisitor new
		read: aSchema;
		schema.
	"^ aSchema
		properties: (self visitAll: aSchema properties);
		items: (self visit: aSchema items);
		type: (self visit: aSchema type);
		yourself		"