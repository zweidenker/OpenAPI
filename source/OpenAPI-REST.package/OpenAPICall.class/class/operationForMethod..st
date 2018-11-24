as yet unclassified
operationForMethod: aString 
	
	^ self pathItem perform: aString asLowercase asSymbol.
	