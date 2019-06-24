as yet unclassified
copyFrom: aDictionary to: aBuilder 
	(aDictionary includesKey: name)
		ifTrue: [ location write: name value: (aDictionary at: name) to: aBuilder ]
		ifFalse: [ 
			required ifTrue: [ OAMissingRequiredParameter signal: 'parameter ', name asString, ' is required but not present' ] ] 