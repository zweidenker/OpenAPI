as yet unclassified
visitOperation: aOperation 
	^ aOperation
		parameters: (self visitAll: aOperation parameters);
		responses: (self visitAll: aOperation responses);
		yourself
