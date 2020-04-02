tests
testOpenAPISpecHasSortedParameters
	| api string json parameters |
	api := OpenAPI fromString: self petStoreApiJsonString.
	string := api specString.
	json := NeoJSONObject fromString: string.
	parameters := (json paths at: #'/pets/{petId}') get parameters.
	self assert: parameters size equals: 2.
	self assert: parameters first name equals: #petId.
	self assert: parameters second name equals: #secondId