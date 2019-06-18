requests
operationWithId: aString arguments: aCollection body: anObject

	^ self 
		operation: (self openApi operationWithId: aString)
		arguments: aCollection 	
		body: anObject
	