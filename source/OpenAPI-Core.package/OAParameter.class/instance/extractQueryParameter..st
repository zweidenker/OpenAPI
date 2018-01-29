extracting
extractQueryParameter: aCall
	| value |
	value := aCall request uri 
		queryAt: name
		ifPresent: [ :val | ^ schema readString: val ].
		
	required ifTrue: [ 
		OAMissingRequiredParameter signal: 'parameter ', name, ' is required but not present' ].
	
	^ nil
	
	