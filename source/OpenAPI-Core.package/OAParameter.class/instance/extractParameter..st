accessing
extractParameter: aCall
	| value |
	value := [location extractParameter: aCall]  on: JSONSchemaError do: [ :ex |
			OAInvalidFormat signal: ex description
		 ].
	value isNil
		ifTrue: [ required
				ifTrue: [ OAMissingRequiredParameter signal: 'parameter ' , name , ' is required but not present' ]
				ifFalse: [ ^ value ] ].
	self validateContraints: value.
	^ value