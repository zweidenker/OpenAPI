tests
testReadIntegerType
	self 
		shouldnt: [ OATypeInteger read: 123 ]
		raise: Exception 
