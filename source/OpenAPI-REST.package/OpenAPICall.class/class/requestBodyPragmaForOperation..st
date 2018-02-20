as yet unclassified
requestBodyPragmaForOperation: aSymbol
	^ self requestBodyPragmas 
		detect: [ :each | each arguments first includesAny: { aSymbol . #common } ]
		ifNone: [ ^ nil ]