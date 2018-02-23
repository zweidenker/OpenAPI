tests
testParsingResponse
	| operation response |
	response := NeoJSONReader fromString: self responseObjectJSON as: OAResponse.

	response should beInstanceOf: OAResponse.
	response description should equal: 'A complex object array response'.

	response content should
		beInstanceOf: Dictionary;
		haveSize: 1;
		includeKey: 'application/json'.
	response content values do: [ :each | each should beInstanceOf: OAMediaTypeObject. ].
	response content inspect.