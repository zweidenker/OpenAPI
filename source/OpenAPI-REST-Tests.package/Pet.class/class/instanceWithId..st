accessing
instanceWithId: aNumber
	^ self instances 
		detect: [ :each | each id = aNumber ]
		ifNone: [ nil ]