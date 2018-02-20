instance creation
readString: aString schema: schema
	^ aString asInteger 
		ifNil: [ OATypeError signal: 'not an integer' ]
	