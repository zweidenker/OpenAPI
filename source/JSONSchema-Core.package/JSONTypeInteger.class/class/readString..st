instance creation
readString: aString
	^ self read: (aString asInteger 
		ifNil: [ OATypeError signal: 'not an integer' ])
	