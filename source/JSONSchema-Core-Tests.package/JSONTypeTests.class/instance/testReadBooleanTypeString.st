tests
testReadBooleanTypeString
	self 
		shouldnt: [ JSONTypeBoolean readString: 'true' ]
		raise: Exception 
