as yet unclassified
requestBodyForOperation: aSymbol

	^ (self requestBodyPragmaForOperation: aSymbol)
		ifNotNil: [ :pragma | 
		  pragma method valueWithReceiver: self arguments: #() ]