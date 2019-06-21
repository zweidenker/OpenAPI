requests
operationWithPath: aString method: method arguments: aCollection body: anObject

	^ self 
		operation: (self operationWithPath: aString andMethod: method)
		arguments: aCollection 	
		body: anObject
	