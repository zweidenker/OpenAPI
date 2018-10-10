tests
testParsingAndSerializingOpenAPI
	| api |
	api := OpenAPI fromString: self petStoreApiJsonString.
	self 
		shouldnt: [ api specString ] 
		raise: Error 