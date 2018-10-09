tests
testPostPetCall
	 
	| response |
	response := self delegate handleRequest: (ZnClient new
		url: '/pets';
		method: #POST;
		entity: (ZnEntity 
			with: '{ "age" : 15, "name" : "fifi" }'
			type: ZnMimeType applicationJson setCharSetUTF8);
		prepareRequest) request.
	self assert: response isSuccess 

			