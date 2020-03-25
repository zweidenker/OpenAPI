tests
testMissingRequiredHeaderParameter
	 
	| response |
	Pet instances add: (Pet new id: 1; name: 'testpet'; age: 1).
	response := self delegate handleRequest: (ZnClient new
		url: '/pets/header-missing';
		method: #GET;
		prepareRequest) request.
	self deny: response isSuccess.
	self assert: response status equals: 400.
	self assert: (response contents includesSubstring: 'Required-Pet-Id')

			