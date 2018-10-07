as yet unclassified
applyParameters: aCollection builder: aBuilder 
	parameters do: [ :parameter |
		 parameter copyFrom: aCollection asDictionary to: aBuilder ]