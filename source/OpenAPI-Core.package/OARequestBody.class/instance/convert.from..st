as yet unclassified
convert: aString from: aZnMimeType 
	( aZnMimeType = ZnMimeType applicationJson ) ifTrue: [ 
		^ NeoJSONReader fromString: aString ].
	Error signal: 'cannot convert mime-type ', aZnMimeType asString