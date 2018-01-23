accessing
extractParameter: aCall 
	(in = #path)
		ifTrue: [ ^ self extractPathParameter: aCall ].
	(in = #query)
		ifTrue: [ ^ self extractQueryParameter: aCall ].
	self halt.