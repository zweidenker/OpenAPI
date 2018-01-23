public
execute
	^ (self respondsTo: self method)	
		ifTrue: [ 
			self initializeParameters.
			(self perform: self method) response ] 
		ifFalse: [ self delegate wrongMethod: request ]  