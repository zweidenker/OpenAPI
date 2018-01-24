accessing
extractParameter: aCall 
	| value |
	(in = #path)
		ifTrue: [ value :=  self extractPathParameter: aCall ].
	(in = #query)
		ifTrue: [ value := self extractQueryParameter: aCall ].
	value isNil 
		ifTrue: [
			required 
				ifTrue: [ OAMissingRequiredParameter signal: 'parameter ', name, ' is required but not present' ]
				ifFalse: [ ^ value ]].
	^ self validateAndConvert: value