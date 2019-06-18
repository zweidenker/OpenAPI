requests
operation: operation arguments: aCollection body: anObject beforeSendDo: aBlock
	|  builder response client |
	builder := OARequestBuilder new 
		baseUri: self baseUri;
		path: operation path;
		client: self httpClient.
		
	operation 
		prepareBuilder: builder;
		applyParameters: aCollection builder: builder;
		applyBody: anObject builder: builder.
		
	client := builder buildClient.
	aBlock ifNotNil: [ aBlock value: client ].
	response := client
		execute;
		response.
	^ operation handleResponse: response.
