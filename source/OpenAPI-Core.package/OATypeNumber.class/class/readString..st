reading
readString: aString
	^ self read: (aString asNumber
		ifNil: [ OATypeError signal: 'not a number' ])
	