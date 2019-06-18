requests
operation: operation arguments: aCollection body: anObject
	^ self 
		operation: operation 
		arguments: aCollection 
		body: anObject 
		beforeSendDo: nil