reading
readString: collection schema: schema
	^ collection collect: [ :each |
		schema items readString: each ]