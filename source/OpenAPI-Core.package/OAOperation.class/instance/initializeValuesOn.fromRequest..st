reading
initializeValuesOn: object fromRequest: request
	self parameters collect: [ :each | 
		each writeParameterValueOn: object ].
