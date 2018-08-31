instance creation
read: aString 
	^ aString asInteger 
		ifNil: [ OATypeError signal: 'not an integer' ]
	