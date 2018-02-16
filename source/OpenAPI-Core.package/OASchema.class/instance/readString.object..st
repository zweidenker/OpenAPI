as yet unclassified
readString: aString object: object
	^ (type = OATypeObject) 
		ifTrue: [ self read: aString object: object]
		ifFalse: [ type readString: aString ]