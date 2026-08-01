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
OpenAPIRestPetTests >> testGetSpecCallReturnsGeneratedDocument [
	"Regression: OpenAPICall class>>isAbstract only treated the literal OpenAPICall as
	abstract (not OpenAPIBasePetCall, a shared intermediate base with no #path of its
	own), and PetsAPI class>>rootCallClass answered the literal OpenAPICall instead of
	its own OpenAPIBasePetCall root - together, OpenAPI>>buildPaths (via
	#withAllSubclasses) tried to build a pathItem for OpenAPIBasePetCall itself,
	crashing with doesNotUnderstand: #path. /spec (OpenAPISpecCall>>get calls
	PetsAPI new specString) was therefore unreachable."
	| response |
	response := self delegate handleRequest: (ZnClient new
		url: '/spec';
		method: #GET;
		prepareRequest) request.
	self assert: response isSuccess.
	self assert: (response entity contents includesSubstring: '/pets')
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
