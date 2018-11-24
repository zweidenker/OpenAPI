as yet unclassified
responsesForMethod: aSymbol

	| responses pragmas pragmaGroups |
	pragmas := (self pragmas: #openApiResponse:status:contentType: includingMethod: aSymbol)
		ifEmpty: [ ^ nil ].
	pragmaGroups := Dictionary new.
	pragmas do: [ :pragma |
		pragma arguments second do: [ :statusCode |
			(pragmaGroups at: statusCode ifAbsentPut: [ OrderedCollection new ])
				add: pragma ] ].
	responses := Dictionary new.
	pragmaGroups keysAndValuesDo: [ :statusCode :statusPragmas | | statusResponse |
		statusResponse := OAResponse new.
		statusPragmas do: [ :pragma |
			pragma value arguments third do: [ :contentType |
				statusResponse contentAtType: contentType put: (pragma method valueWithReceiver: self arguments: #()) ] ].
		responses at: statusCode put: statusResponse ].

	^ responses