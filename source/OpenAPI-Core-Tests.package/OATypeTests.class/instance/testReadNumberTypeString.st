tests
testReadNumberTypeString
	self 
		shouldnt: [ OATypeNumber readString: '123' ]
		raise: OATypeError  
