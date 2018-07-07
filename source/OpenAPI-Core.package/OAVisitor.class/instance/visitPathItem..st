as yet unclassified
visitPathItem: aPathItem 
	aPathItem implementedMethods do: [ :method |
		aPathItem instVarNamed: method put: (self visit: (aPathItem perform: method))  ]. 
	^ aPathItem 