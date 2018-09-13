accessing
id 
	^ id ifNil: [ 
		id := self class instances size + 1 ]