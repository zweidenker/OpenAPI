reading-primitive data
readString: aString
	(aString = 'true') ifTrue: [ 
		^ true ].
	(aString = 'false') ifTrue: [ 
		^ false ].
	^ OATypeError signal: 'not a boolean'
	