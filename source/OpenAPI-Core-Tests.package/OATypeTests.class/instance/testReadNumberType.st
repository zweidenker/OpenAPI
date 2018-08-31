tests
testReadNumberType
	self 
		shouldnt: [ OATypeNumber read: 123 ]
		raise: Exception 
