Class {
	#name : 'OpenAPIRestPetTests',
	#superclass : 'OpenAPIRestTests',
	#category : 'OpenAPI-REST-Tests',
	#package : 'OpenAPI-REST-Tests'
}

{ #category : 'tests' }
OpenAPIRestPetTests >> rootCallClass [
	^ OpenAPIBasePetCall
]

{ #category : 'tests' }
OpenAPIRestPetTests >> testGetPetCall [
	 
	| response |
	Pet instances add: (Pet new id: 1; name: 'testpet'; age: 1).
	response := self delegate handleRequest: (ZnClient new
		url: '/pets/1';
		method: #GET;
		prepareRequest) request.
	self assert: response isSuccess 

			
]

{ #category : 'tests' }
OpenAPIRestPetTests >> testPostPetCall [
	 
	| response |
	response := self delegate handleRequest: (ZnClient new
		url: '/pets';
		method: #POST;
		entity: (ZnEntity 
			with: '{ "age" : 15, "name" : "fifi" }'
			type: ZnMimeType applicationJson setCharSetUTF8);
		prepareRequest) request.
	self assert: response isSuccess 

			
]
