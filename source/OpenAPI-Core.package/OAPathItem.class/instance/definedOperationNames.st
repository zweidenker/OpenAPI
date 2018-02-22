accessing
definedOperationNames
	^ (self methods intersection: self class instVarNames)
		reject: [ :each | (self instVarNamed: each) isNil. ].