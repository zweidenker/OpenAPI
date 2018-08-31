tests
testReadBooleanTypeMismatch
	self 
		should: [ JSONTypeBoolean read: 123]
		raise: JSONTypeErrror  
