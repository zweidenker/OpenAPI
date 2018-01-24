public
execute
	^ (self respondsTo: self method)	
		ifTrue: [ 
			[ self initializeParameters.
			(self perform: self method) response ]
				on: OAError 
				do: [ :err | self handleError: err ] ] 
		ifFalse: [ self delegate wrongMethod: request ]  