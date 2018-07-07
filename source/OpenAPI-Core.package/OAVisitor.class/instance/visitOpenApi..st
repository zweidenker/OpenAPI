as yet unclassified
visitOpenApi: anApi
	^ anApi
		info: (self visit: anApi info);
		servers: (self visitAll: anApi  servers);
		paths: (self visitAll: anApi paths);
		components: (self visit: anApi components);
		security: (self visit: anApi security);
		tags: (self visitAll: anApi tags);
		externalDocs: (self visit: anApi externalDocs);
		yourself