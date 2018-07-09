printing
implementedMethods
	^ (self methods intersection: self class instVarNames) 
		reject: [:each | (self instVarNamed: each) isNil ]
