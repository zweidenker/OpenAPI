tests
testReadNumberTypeString
	self 
		shouldnt: [ JSONTypeNumber readString: '123' ]
		raise: JSONTypeErrror  
