tests
testParsingOpenAPI
	| api path |
	api := OpenAPI fromString: self openApiJsonString.
	self assert: api info title equals: 'Sample Pet Store App'.
	self assert: api openapi equals: '3.0.0'.
	self assert: api paths size = 1.

	api paths should haveSize: 1.

	path := api paths values first.
	path should beInstanceOf: OAPathItem.