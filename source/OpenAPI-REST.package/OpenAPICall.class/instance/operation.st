initialization
operation
	^ operation ifNil: [
		operation := self operationForMethod: request method asLowercase ]
