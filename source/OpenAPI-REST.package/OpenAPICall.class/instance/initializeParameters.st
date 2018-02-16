initialization
initializeParameters
	| operation |
	operation := self class operationForMethod: request method asLowercase.
	operation 
		initializeValuesOn: self valueObject
		fromRequest: self