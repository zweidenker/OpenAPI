accessing
content: aDictionary
	aDictionary ifNotNil: [  
		aDictionary values do: [ :each | each response: self ].
		content := aDictionary ]