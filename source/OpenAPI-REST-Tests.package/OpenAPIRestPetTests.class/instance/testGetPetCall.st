tests
testGetPetCall
	 
	| response |
	Pet instances add: (Pet new id: 1; name: 'testpet'; age: 1).
	response := self delegate handleRequest: (ZnClient new
		url: '/pets/1';
		method: #GET;
		prepareRequest) request.
	self assert: response isSuccess 

			