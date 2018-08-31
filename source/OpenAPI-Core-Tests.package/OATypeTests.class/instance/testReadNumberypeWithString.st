tests
testReadNumberypeWithString
	self 
		should: [ OATypeNumber read: '123' ]
		raise: OATypeError  
