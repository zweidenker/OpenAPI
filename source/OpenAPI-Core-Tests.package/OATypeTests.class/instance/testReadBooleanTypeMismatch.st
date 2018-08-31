tests
testReadBooleanTypeMismatch
	self 
		should: [ OATypeBoolean read: 123]
		raise: OATypeError  
