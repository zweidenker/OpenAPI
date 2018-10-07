requests
call: aString withArguments: aCollection
	^ self 
		operation: (self openApi operationWithId: aString)
		arguments: aCollection	
