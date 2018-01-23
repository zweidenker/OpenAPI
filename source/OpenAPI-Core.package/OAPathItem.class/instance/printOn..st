printing
printOn: stream
	stream
		<< 'Methods: ' 
		<< ($, join: ((self methods intersection: self class instVarNames) reject: [:each | (self instVarNamed: each) isNil ]))
