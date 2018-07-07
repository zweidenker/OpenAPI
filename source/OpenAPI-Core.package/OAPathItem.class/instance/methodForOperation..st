accessing
methodForOperation: anOperation 
	self methods do: [ :method |
		((self instVarNamed: method) = anOperation) ifTrue: [ 
			^ method ] ].
	^ nil