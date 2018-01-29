validation
validate: anObject
	(anObject isKindOf: Boolean) ifFalse: [ 
		OATypeError signal: anObject asString, ' is not a boolean ' ]