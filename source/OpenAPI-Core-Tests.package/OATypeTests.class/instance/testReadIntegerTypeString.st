tests
testReadIntegerTypeString
	self 
		shouldnt: [ OATypeInteger readString: '123' ]
		raise: OATypeError  
