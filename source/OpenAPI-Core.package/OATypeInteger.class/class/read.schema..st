instance creation
read: aString schema: schema
	^ aString asInteger 
		ifNil: [ OATypeError signal: 'not an integer' ]
	