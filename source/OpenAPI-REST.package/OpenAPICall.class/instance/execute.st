public
execute
	^ (self respondsTo: self method)	
		ifTrue: [ 
			[ 
			self preProcess.
			self perform: self method.
			self postProcess. 
			response]
				on: self errorClasses
				do: [ :err | self handleError: err ] ] 
		ifFalse: [ self delegate wrongMethod: request ]  