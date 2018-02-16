accessing
contentAt: aString put: value
	content ifNil: [ content := Dictionary new ].
	content
		at: aString
		put: value