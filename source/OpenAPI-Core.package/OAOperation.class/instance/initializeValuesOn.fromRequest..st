reading
initializeValuesOn: object fromRequest: request
	parameters ifNotNil: [
		parameters do: [ :each | 
			each writeParameterValueOn: object request: request]].
	requestBody ifNotNil: [ 
		(requestBody readFrom: request object: object) ]
