extracting
extractQueryParameter: aCall
	| value |
	value := aCall request uri 
		queryAt: name
		ifAbsent: [ 
			required ifTrue: [ 
				OAMissingRequiredParameter signal: 'parameter ', name, ' is required but not present' ]].
	^ schema readString: value