visiting
visit: anObject
	(seen includes: anObject) 
		ifTrue: [ ^ anObject ].
	seen add: anObject.
	^ super visit: anObject