visiting
visitMediaTypeObject: aMediaTypeObject 
	^ aMediaTypeObject
		schema: (self visit: aMediaTypeObject schema);
		yourself.
