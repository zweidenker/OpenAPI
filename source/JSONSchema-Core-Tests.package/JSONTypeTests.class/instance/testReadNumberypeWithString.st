tests
testReadNumberypeWithString
	self 
		should: [ JSONTypeNumber read: '123' ]
		raise: OATypeError  
