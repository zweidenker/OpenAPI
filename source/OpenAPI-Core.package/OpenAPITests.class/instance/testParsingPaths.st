tests
testParsingPaths
	| paths |
	paths := (NeoJSONReader on: self pathsObjectJSON readStream) 
		for: #OAPaths customDo: [ :mapping |
			mapping mapWithValueSchema: OAPathItem  ];
		nextAs: #OAPaths.
	self assert: paths notEmpty. 
