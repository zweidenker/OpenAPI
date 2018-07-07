as yet unclassified
visitComponents: aComponents 
	^ aComponents
		schemas: (self visitAll: aComponents schemas);
		responses: (self visitAll: aComponents responses);
		parameters: (self visitAll: aComponents parameters);
		examples: (self visitAll: aComponents examples);
		requestBodies: (self visitAll: aComponents requestBodies);
		headers: (self visitAll: aComponents headers);
		securitySchemes: (self visitAll: aComponents securitySchemes);
		links: (self visitAll: aComponents links);
		callbacks: (self visitAll: aComponents callbacks);
		yourself 
