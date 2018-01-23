as yet unclassified
validate: anObject
	schema ifNotNil: [ 
		schema validate: anObject ]