requests
callPath: aString method: method withArguments: aCollection

	^ self 
		operation: ((openApi operationWithPath: aString) perform: method asSymbol)
		withArguments: aCollection 	
	