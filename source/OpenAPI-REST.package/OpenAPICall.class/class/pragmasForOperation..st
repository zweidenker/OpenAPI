as yet unclassified
pragmasForOperation: aSymbol
	^ self parameterPragmas select: [ :each | 
			each arguments first includesAny: { aSymbol . #common } ]