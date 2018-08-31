reading-primitive data
read: aBoolean
	(aBoolean isKindOf: Boolean) ifFalse: [  
		^ OATypeError signal: 'not a boolean' ].
	^ aBoolean
	