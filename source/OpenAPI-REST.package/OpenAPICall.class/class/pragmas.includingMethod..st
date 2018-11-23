as yet unclassified
pragmas: pragmaName includingMethod: aSymbol
	^ (self openApiPragmasNamed: pragmaName) 
		select: [ :each | 
			each arguments first includesAny: { aSymbol . #common } ]