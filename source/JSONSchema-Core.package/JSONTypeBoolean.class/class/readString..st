reading-primitive data
readString: aString
	(aString = 'true') ifTrue: [ 
		^ true ].
	(aString = 'false') ifTrue: [ 
		^ false ].
	^ JSONTypeErrror signal: 'not a boolean'
	