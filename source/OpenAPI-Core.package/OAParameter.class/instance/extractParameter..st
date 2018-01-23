accessing
extractParameter: aCall 
	(in = #path)
		ifTrue: [ ^ self extractPathParameter: aCall ].
	self halt.