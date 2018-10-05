as yet unclassified
visitOperation: anOperation 
	^ anOperation
		requestBody: (self visit: anOperation requestBody);
		parameters: (self visitAll: anOperation parameters);
		responses: (self visitAll: anOperation responses);
		yourself
