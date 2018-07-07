as yet unclassified
operationWithId: aString 
	self paths do: [ :path |
		path implementedOperations 
			detect: [ :operation | operation operationId = aString ]
			ifFound: [ :operation | ^ operation  ] ].
	^ nil