tests
testGetPetCall
	 
	| response |
	response := self delegate handleRequest: (ZnClient new
		url: '/pets/1234';
		method: #GET;
		prepareRequest) request.
	self assert: response isSuccess 

			