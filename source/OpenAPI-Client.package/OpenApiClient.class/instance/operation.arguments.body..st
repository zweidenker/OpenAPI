requests
operation: operation arguments: aCollection body: anObject
	|  builder response |
	builder := OARequestBuilder new 
		baseUri: self baseUri;
		path: operation path;
		client: self httpClient.
		
	operation 
		prepareBuilder: builder;
		applyParameters: aCollection builder: builder;
		applyBody: anObject builder: builder.
		
	response := builder buildClient
		execute;
		response.
	^ operation handleResponse: response.
