tests
testReadBooleanType
	self 
		shouldnt: [ OATypeBoolean read: true ]
		raise: Exception 
