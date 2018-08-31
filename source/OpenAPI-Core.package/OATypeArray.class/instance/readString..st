reading
readString: collection
	^ collection collect: [ :each |
		schema items readString: each ]