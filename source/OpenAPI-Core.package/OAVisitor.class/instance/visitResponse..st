visting
visitResponse: aResponse 
	^ aResponse
		content: (self visitDictionary: aResponse content );
		yourself