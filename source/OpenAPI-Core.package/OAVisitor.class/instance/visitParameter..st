vistiting
visitParameter: aParameter 
	^ aParameter 
		schema: (self processSchema: aParameter schema);
		examples: (self visitAll: aParameter examples);
		content: (self visit: aParameter content);
		yourself