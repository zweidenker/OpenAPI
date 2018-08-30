accessing
typeString: aString 
	type := (OAType typeNamed: aString)
		schema: self;
		yourself 