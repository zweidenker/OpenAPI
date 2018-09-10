visiting
visitSchema: aSchema 
	^ aSchema
		"properties: (self visitAll: aSchema properties);"
		"items: (self visit: aSchema items);"
		type: (self visit: aSchema type);
		yourself		