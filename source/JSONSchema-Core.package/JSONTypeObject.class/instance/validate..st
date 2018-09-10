validation
validate: aDictionary 
	self required do: [ :requiredProperty |
		(aDictionary includesKey: requiredProperty) ifFalse: [ 
			JSONSchemaMissingRequiredProperty new
				property: requiredProperty;
				signal: 'Property not found' ] ].
	properties associationsDo: [ :property | 
		aDictionary 
			at: property key 
			ifPresent: [ :elementValue  | property value validate: elementValue ] ]