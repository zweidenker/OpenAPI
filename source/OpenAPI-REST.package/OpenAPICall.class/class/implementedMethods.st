as yet unclassified
implementedMethods
	^ self httpMethods select: [ :method | self includesSelector: method asSymbol ]
