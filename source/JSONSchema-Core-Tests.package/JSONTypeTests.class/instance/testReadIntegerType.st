tests
testReadIntegerType
	self 
		shouldnt: [ JSONTypeInteger read: 123 ]
		raise: Exception 
