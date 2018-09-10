tests
testReadBooleanTypeMismatch
	self 
		should: [ JSONTypeBoolean new read: 123]
		raise: JSONTypeErrror  
