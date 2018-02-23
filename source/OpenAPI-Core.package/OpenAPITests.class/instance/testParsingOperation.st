tests
testParsingOperation
	| operation responses response405 response200 |
	operation := NeoJSONReader fromString: self operationObjectJSON as: OAOperation.
	self assert: operation summary equals: 'Updates a pet in the store with form data'.


	responses := operation responses.

	responses should
		beInstanceOf: Dictionary;
		haveSize: 2;
		includeKey: '405';
		includeKey: '200'.

	response405 := responses at: '405'.
	response405 should beInstanceOf: OAResponse.
	response405 description should equal: 'Invalid input'.
	"response405 headers should beInstanceOf: OAHeader."
	response405 content should
		beInstanceOf: Dictionary;
		haveSize: 2;
		includeKey: 'application/json';
		includeKey: 'application/xml'.
	response405 content values do: [ :each | each should beInstanceOf: OAMediaTypeObject. ].

	response200 := responses at: '200'.
	response200 should beInstanceOf: OAResponse.
	response200 description should equal: 'Pet updated.'.
	response200 content should
		beInstanceOf: Dictionary;
		haveSize: 2;
		includeKey: 'application/json';
		includeKey: 'application/xml'.
	response200 content values do: [ :each | each should beInstanceOf: OAMediaTypeObject. ].