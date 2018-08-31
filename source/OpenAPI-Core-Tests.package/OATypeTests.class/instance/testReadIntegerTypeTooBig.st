tests
testReadIntegerTypeTooBig
	self 
		should: [ OATypeInteger read: (2 raisedTo: 33) ]
		raise: OATypeError 
