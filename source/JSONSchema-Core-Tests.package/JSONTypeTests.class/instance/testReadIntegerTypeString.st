tests
testReadIntegerTypeString
	self 
		shouldnt: [ JSONTypeInteger readString: '123' ]
		raise: JSONTypeErrror  
