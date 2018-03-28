accessing
extractParameter: aCall
	| value |
	value := location extractParameter: aCall.
	value isNil
		ifTrue: [ required
				ifTrue: [ OAMissingRequiredParameter signal: 'parameter ' , name , ' is required but not present' ]
				ifFalse: [ ^ value ] ].
	^ self validateAndConvert: value.