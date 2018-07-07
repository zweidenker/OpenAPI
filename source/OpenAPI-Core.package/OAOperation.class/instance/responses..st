accessing
responses: aDictionary
	aDictionary values do: [ :each | each operation: self ].
	responses := aDictionary