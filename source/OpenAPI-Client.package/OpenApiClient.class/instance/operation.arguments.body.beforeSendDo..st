requests
operation: operation arguments: aCollection body: anObject beforeSendDo: aBlock
	| builder response client responseContent |
	
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
	responseContent := operation handleResponse: response.
	^ response isSuccess 
		ifTrue: [  responseContent ]
		ifFalse: [ self handleError: responseContent request: client request response: response ] 