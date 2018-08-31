validating
validate: aString 
	aString isString ifFalse: [ 
		OATypeError signal: aString asString, ' is not a string ' ]