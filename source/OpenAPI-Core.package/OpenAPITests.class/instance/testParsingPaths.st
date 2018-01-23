tests
testParsingPaths
	| paths string |
	paths := NeoJSONReader fromString: self pathsObjectJSON as: OAPaths.
	self assert: paths notEmpty. 
