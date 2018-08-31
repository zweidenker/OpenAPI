tests
testParsingPetStore
	| api |
	api := OpenAPI fromString: self petStoreApiJsonString.
	self assert: api info title equals: 'Swagger Petstore'. 
	self assert: api openapi equals: '3.0.0'.
	self assert: api paths size = 2.
