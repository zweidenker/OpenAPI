tests
testParsingRequestBody
	| requestBody |
	requestBody := NeoJSONReader fromString: self requestBodyString as: OARequestBody.
	self assert: (requestBody contentAt: 'application/json') schema class equals: OAReference. 
