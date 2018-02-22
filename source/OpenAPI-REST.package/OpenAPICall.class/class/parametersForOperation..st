as yet unclassified
parametersForOperation: aSymbol
	^ ( self pragmasForOperation: aSymbol )
		collect: [:each | each method valueWithReceiver: self arguments: #() ]
