visting
visitSchema: aSchema 
	^ aSchema
		properties: (self visit: aSchema properties);
		items: (self visit: aSchema items);
		yourself		