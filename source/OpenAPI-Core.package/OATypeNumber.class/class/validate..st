validation
validate: anObject
	(anObject isKindOf: Number) ifFalse: [ 
		OATypeError signal: anObject asString, ' is not a number ' ]	
	