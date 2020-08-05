tests
testMissingOptionalHeaderParameter
	 
	| response |
	Pet instances add: (Pet new id: 1; name: 'testpet'; age: 1).
	response := self delegate handleRequest: (ZnClient new
		url: '/pets/header-missing';
		headerAt: 'Required-Pet-Id' add: '123';
		method: #GET;
		prepareRequest) request.
	self assert: response isSuccess 

			