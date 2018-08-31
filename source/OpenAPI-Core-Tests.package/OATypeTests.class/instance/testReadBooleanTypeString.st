tests
testReadBooleanTypeString
	self 
		shouldnt: [ OATypeBoolean readString: 'true' ]
		raise: Exception 
