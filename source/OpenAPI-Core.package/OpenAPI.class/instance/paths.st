accessing
paths
	^ paths ifNil: [ 
		paths := self buildPaths ]