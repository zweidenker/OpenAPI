visiting
visitComposedType: aComposedType 
	^ aComposedType 
		schemas: (self visitAll: aComposedType schemas)