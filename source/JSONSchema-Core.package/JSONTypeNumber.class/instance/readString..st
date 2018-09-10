reading
readString: aString
	^ self read: (aString asNumber
		ifNil: [ JSONTypeErrror signal: 'not a number' ])
	