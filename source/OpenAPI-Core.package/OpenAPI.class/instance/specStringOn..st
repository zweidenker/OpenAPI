as yet unclassified
specStringOn: stream
	^ (OAJSONWriter on: stream)
		prettyPrint: true;
		nextPut: self
		