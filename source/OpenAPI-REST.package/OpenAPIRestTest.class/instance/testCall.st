tests
testCall
	 
	| response |
	response := self delegate handleRequest: (ZnClient new
		url: '/pets/1234';
		method: #GET;
		prepareRequest) request.
		self halt.
			