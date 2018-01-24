converting
readType: aString 
	^ [ DateAndTime fromString: aString ]
		on: Error 
		do: [ :error | OAInvalidFormat signal: 'format is not dateAndTime for ', aString ]