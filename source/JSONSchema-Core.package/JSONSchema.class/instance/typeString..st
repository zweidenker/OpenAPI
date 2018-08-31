accessing
typeString: aString 
	type := (JSONType typeNamed: aString)
		schema: self;
		yourself 