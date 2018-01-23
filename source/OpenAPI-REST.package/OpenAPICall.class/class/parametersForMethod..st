as yet unclassified
parametersForMethod: aString 
	
	| operation |
	operation := self pathItem perform: aString asSymbol.
	^ operation parameters 