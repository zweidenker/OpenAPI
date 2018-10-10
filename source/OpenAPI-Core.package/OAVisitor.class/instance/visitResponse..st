visting
visitResponse: aResponse 
	^ aResponse
		headers: (self visitAll: aResponse headers);
		content: (self visitDictionary: aResponse content );
		yourself