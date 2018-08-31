tests
testReadIntegerTypeWithString
	self 
		should: [ OATypeInteger read: '123' ]
		raise: OATypeError  
