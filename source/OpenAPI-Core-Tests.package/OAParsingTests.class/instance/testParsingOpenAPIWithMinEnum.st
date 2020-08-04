tests
testParsingOpenAPIWithMinEnum
	| api path |
	api := OpenAPI fromString: self petStoreApiJsonStringWithEnum.
	self assert: api info title equals: 'Swagger Petstore'.
	self assert: api openapi equals: '3.0.0'.
	self assert: api paths size = 2.

	path := api paths values first.
	path should beInstanceOf: OAPathItem.