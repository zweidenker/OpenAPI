as yet unclassified
applyParameters: aCollection builder: aBuilder 
	parameters isNil ifTrue: [ ^ self ].
	parameters do: [ :parameter |
		 parameter copyFrom: aCollection asDictionary to: aBuilder ]