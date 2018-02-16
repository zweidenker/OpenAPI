accessing
contentAt: aString 
	content ifNotNil: [ 
		content
			at: aString
			ifPresent: [ :value | ^ value ] ].
	NotFound signal: 'no content for ', aString, 'found'