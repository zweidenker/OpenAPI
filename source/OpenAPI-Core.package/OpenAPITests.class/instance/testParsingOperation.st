tests
testParsingOperation
	| operation string |
	operation := NeoJSONReader fromString: self operationObjectJSON as: OAOperation.
	self assert: operation summary equals: 'Updates a pet in the store with form data'
