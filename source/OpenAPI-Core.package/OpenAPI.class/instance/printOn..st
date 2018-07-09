printing
printOn: aStream
	aStream << 'OpenAPI '.
	info ifNotNil: [ 
		info printOn: aStream  ]