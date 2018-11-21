as yet unclassified
specStringOn: stream
	^ (OAJSONWriter on: stream)
		prettyPrint: true;
		newLine: String crlf;
		nextPut: self
		