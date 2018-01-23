accessing
extractPathParameter: aCall
	| index value |
	($/ split: aCall class path allButFirst) withIndexDo: [ :each :idx |
		(each allButFirst allButLast = name ) ifTrue: [ 
			index := idx ] ].
	value := aCall request uri pathSegments at: index.
	self validate: value.
	^ value