tests
testParsingOpenAPI
	| api |
	api := OpenAPI fromString: self openApiJsonString.
	self assert: api info title equals: 'Sample Pet Store App'. 
	self halt.
