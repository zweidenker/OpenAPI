as yet unclassified
operationWithId: aString 
	^ operations 
		detect: [ :each | each id = aString ]
		ifNone: [ nil ]