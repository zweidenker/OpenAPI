*jsonschema-core
peekFirstKey
	| stream |
	stream := readStream clone.
	stream upTo: $".
	^ (stream upTo: $")