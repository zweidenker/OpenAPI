tests
testReadIntegerTypeWithString
	self 
		should: [ JSONTypeInteger read: '123' ]
		raise: JSONTypeErrror  
