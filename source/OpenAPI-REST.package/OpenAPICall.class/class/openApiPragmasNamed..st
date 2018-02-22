as yet unclassified
openApiPragmasNamed: aSymbol
	^ Pragma 
		allNamed: aSymbol
		from: self class 
		to: OpenAPICall class.