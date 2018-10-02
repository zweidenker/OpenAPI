requests
call: aString withArguments: aCollection
	^ self 
		operation: (openApi operationWithId: aString)
		withArguments: aCollection	
