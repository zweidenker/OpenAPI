initialization
initializeParameters
	(self class parametersForMethod: request method asLowercase)
		collect: [ :each | 
			each writeParameterValueOn: self ]
