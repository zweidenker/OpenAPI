reading-primitive data
read: aBoolean
	(aBoolean isKindOf: Boolean) ifFalse: [  
		^ JSONTypeErrror signal: 'not a boolean' ].
	^ aBoolean
	