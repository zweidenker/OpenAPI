accessing
operations
	^ operations ifNil: [ 
		operations := Dictionary new ]