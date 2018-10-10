as yet unclassified
specStringOn: stream
	^ (OAJSONWriter on: stream)
		nextPut: self