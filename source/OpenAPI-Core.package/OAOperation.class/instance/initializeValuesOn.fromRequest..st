reading
initializeValuesOn: object fromRequest: request
	parameters ifNotNil: [
		parameters do: [ :each | 
			each writeParameterValueOn: object request: request]].
	requestBody ifNotNil: [ 
		"visitor := OAReadVisitor new
			object: object;
			call: request;
			visit: requestBody."
		"object instVarNamed: #body put:" 
		(requestBody readFrom: request object: object) ]
