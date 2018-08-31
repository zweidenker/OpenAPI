visiting
visitAll: aCollection 
	aCollection ifNil: [ ^ nil ].
	^ aCollection collect: [ :each |
		self visit: each ]