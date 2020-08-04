tests
testParsingResponseWithLinks
	| response |
	response := NeoJSONReader fromString: self responseObjectJSONWithLinks as: OAResponse.

	response should beInstanceOf: OAResponse.
	response description should equal: 'Response with links'.

	response content should
		beInstanceOf: Dictionary;
		haveSize: 1;
		includeKey: 'application/json'.
	response content values do: [ :each | each should beInstanceOf: OAMediaTypeObject. ].