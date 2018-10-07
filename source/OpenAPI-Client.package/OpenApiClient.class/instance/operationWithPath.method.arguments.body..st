requests
operationWithPath: aString method: method arguments: aCollection body: anObject

	^ self 
		operation: ((self openApi operationWithPath: aString) perform: method asSymbol)
		arguments: aCollection 	
		body: anObject
	