tests
testReadNumberType
	self 
		shouldnt: [ JSONTypeNumber read: 123 ]
		raise: Exception 
