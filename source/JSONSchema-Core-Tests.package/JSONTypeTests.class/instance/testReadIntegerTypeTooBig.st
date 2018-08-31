tests
testReadIntegerTypeTooBig
	self 
		should: [ JSONTypeInteger read: (2 raisedTo: 33) ]
		raise: JSONTypeErrror 
