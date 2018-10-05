requests
operation: operation withArguments: aCollection
	|  response path uri queries body client |
	path :=  operation path.
	aCollection do: [ :assoc | 
		operation parameterWithName: assoc key ifFound: [ :param | 
		(param location isKindOf: OAPathParameterLocation) ifTrue: [ 
			path := path format: { param name -> assoc value } asDictionary  ]
		 ] ].
	queries := Dictionary new.
	aCollection do: [ :assoc | 
		operation parameterWithName: assoc key ifFound: [:param |
		(param location isKindOf: OAQueryParameterLocation) ifTrue: [ 
			queries add: (param name -> assoc value) ]
		 ] ].
	operation hasBody ifTrue: [  
		(operation mediaTypeObjectFor: 'application/json') ifNotNil: [ :mediaObject | | object |
			body := Dictionary new.
			aCollection do: [ :assoc |
				body at: assoc key put: assoc value ].
			 ] ].
	client := ZnClient new.
	uri := self baseUri / path.
	uri queryAddAll: queries.
	client 
		url: uri;
		method: operation method asUppercase.
	body ifNotNil: [ 
		client entity: (ZnEntity 
			with: (NeoJSONWriter toStringPretty: body)
			type: ZnMimeType applicationJson setCharSetUTF8) ].
	response := client
		execute;
		response.
	^ operation handleResponse: response.
