requests
operation: operation withArguments: aCollection
	|  response path uri queries |
	path :=  operation path.
	aCollection do: [ :assoc | | param |
		param := operation parameterWithName: assoc key.
		(param location isKindOf: OAPathParameterLocation) ifTrue: [ 
			path := path format: { param name -> assoc value } asDictionary  ]
		 ].
	queries := Dictionary new.
	aCollection do: [ :assoc | | param |
		param := operation parameterWithName: assoc key.
		(param location isKindOf: OAQueryParameterLocation) ifTrue: [ 
			queries add: (param name -> assoc value) ]
		 ].
	uri := self baseUri / path.
	uri queryAddAll: queries.
	response := ZnClient new
		url: uri;
		method: operation method asUppercase;
		execute;
		response.
	^ operation handleResponse: response.
