visiting
visitMediaTypeObject: aMediaTypeObject 

	^ aMediaTypeObject
		schema: (self processSchema: aMediaTypeObject schema);
		yourself.
