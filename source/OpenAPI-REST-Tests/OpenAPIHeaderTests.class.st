Class {
	#name : 'OpenAPIHeaderTests',
	#superclass : 'OpenAPIRestTests',
	#category : 'OpenAPI-REST-Tests',
	#package : 'OpenAPI-REST-Tests'
}

{ #category : 'tests' }
OpenAPIHeaderTests >> testMissingOptionalHeaderParameter [
	 
	| response |
	Pet instances add: (Pet new id: 1; name: 'testpet'; age: 1).
	response := self delegate handleRequest: (ZnClient new
		url: '/pets/header-missing';
		headerAt: 'Required-Pet-Id' add: '123';
		method: #GET;
		prepareRequest) request.
	self assert: response isSuccess 

			
]

{ #category : 'tests' }
OpenAPIHeaderTests >> testMissingRequiredHeaderParameter [
	 
	| response |
	Pet instances add: (Pet new id: 1; name: 'testpet'; age: 1).
	response := self delegate handleRequest: (ZnClient new
		url: '/pets/header-missing';
		method: #GET;
		prepareRequest) request.
	self deny: response isSuccess.
	self assert: response status equals: 400.
	self assert: (response contents includesSubstring: 'Required-Pet-Id')

			
]
