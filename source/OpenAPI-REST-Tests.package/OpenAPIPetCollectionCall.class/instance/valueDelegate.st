accessing
valueDelegate
	^ valueDelegate ifNil: [ 
		valueDelegate := Pet new ]