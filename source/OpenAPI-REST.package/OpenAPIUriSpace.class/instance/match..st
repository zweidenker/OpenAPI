public
match: request
	(rootClass allSubclasses reject: #isAbstract)
		do: [ :callClass |
			(callClass match: request) ifTrue: [ 
				^ callClass new ] ].
	^ nil
		