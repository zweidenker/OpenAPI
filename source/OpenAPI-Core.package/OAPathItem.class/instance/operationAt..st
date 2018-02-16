as yet unclassified
operationAt: aSymbol
	^ (self instVarNamed: aSymbol) ifNil: [ 
		self instVarNamed: aSymbol put: OAOperation new ]