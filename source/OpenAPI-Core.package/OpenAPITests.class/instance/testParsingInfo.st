tests
testParsingInfo
	| info |
	info := NeoJSONReader fromString: self infoObjectJSON as: OAInfo.
	self assert: info title equals: 'Sample Pet Store App'. 