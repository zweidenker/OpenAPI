visting
visitAll: aCollection 
	^ aCollection collect: [ :each |
		self visit: each ]