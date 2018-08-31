instance creation
readString: aString
	^ self read: (aString asInteger 
		ifNil: [ JSONTypeErrror signal: 'not an integer' ])
	