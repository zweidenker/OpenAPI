tests
testParsingOpenAPI
	| api |
	api := OpenAPI fromString: self openApiJsonString.
	self assert: api info title equals: 'Sample Pet Store App'. 
	self assert: api openapi equals: '3.0.0'.
	self assert: api paths size = 1
