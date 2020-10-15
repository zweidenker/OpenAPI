reading
extractParameter: aCall
	| index value |
	($/ split: aCall class path allButFirst) withIndexDo: [ :each :idx |
		((each size > 1) and: [ each allButFirst allButLast = self parameterName ]) ifTrue: [ 
			index := idx ] ].
	value := aCall request uri pathSegments at: index.
	^ parameter read: value.
