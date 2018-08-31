tests
testReadBooleanType
	self 
		shouldnt: [ JSONTypeBoolean read: true ]
		raise: Exception 
