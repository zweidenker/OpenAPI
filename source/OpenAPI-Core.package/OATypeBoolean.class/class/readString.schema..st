reading-primitive data
readString: aString schema: schema
	(aString = 'true') ifTrue: [ 
		^ true ].
	(aString = 'false') ifTrue: [ 
		^ false ].
	^ OATypeError signal: 'not a boolean'
	