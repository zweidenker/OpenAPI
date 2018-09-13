accessing
responses: aDictionary
	aDictionary ifNil: [ ^ self ].
	aDictionary values do: [ :each | each operation: self ].
	responses := aDictionary