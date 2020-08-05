reading
initializeValuesOn: aCall fromRequest: request
	parameters ifNotNil: [
		parameters do: [ :each | 
			each 
				writeParameterValueOn: aCall parameterValueDelegate 
				request: request]].
	requestBody ifNotNil: [ 
		(requestBody 
			readFrom: request 
			object: aCall bodyValueDelegate ) ]
