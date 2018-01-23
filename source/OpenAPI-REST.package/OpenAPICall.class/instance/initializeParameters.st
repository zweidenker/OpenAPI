as yet unclassified
initializeParameters
	(self class parametersForMethod: request method asLowercase)
		collect: [ :each | 
			self instVarNamed: each name put: (each extractParameter: self) ].
