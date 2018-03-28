as yet unclassified
extractParameter: aCall
	| index value |
	($/ split: aCall class path allButFirst) withIndexDo: [ :each :idx |
		(each allButFirst allButLast = self parameterName ) ifTrue: [ 
			index := idx ] ].
	value := aCall request uri pathSegments at: index.
	parameter validate: value.
	^ value