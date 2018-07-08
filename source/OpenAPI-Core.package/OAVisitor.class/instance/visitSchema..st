visting
visitSchema: aSchema 
	^ aSchema
		properties: (self visitAll: aSchema properties);
		items: (self visit: aSchema items);
		yourself		