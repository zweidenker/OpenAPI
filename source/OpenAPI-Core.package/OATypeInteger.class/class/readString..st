instance creation
readString: aString
	^ aString asInteger 
		ifNil: [ OATypeError signal: 'not an integer' ]
	