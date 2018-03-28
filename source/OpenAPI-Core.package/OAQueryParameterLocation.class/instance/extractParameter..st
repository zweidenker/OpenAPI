accessing
extractParameter: aCall
	| value |
	value := aCall request uri 
		queryAt: self parameterName
		ifPresent: [ :val | self parameterSchema readString: val ].
		
	"
	required ifTrue: [ 
		OAMissingRequiredParameter signal: 'parameter ', name, ' is required but not present' ].
	"
	"value ifNil: [self halt]."
	^ value
	
	