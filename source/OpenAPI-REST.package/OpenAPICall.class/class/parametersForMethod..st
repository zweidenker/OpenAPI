as yet unclassified
parametersForMethod: aSymbol
	^ self objectsForPragmas: ( self pragmas: #openApiParameter: includingMethod: aSymbol )
		