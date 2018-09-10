instance creation
validate: anObject
	(anObject isKindOf: Integer) ifFalse: [ 
		JSONTypeErrror signal: anObject asString, ' is not an integer ' ].

"	(anObject between: (2 raisedTo: 31) negated and: (2 raisedTo: 31) - 1) ifFalse: [ 
		JSONTypeErrror signal: anObject asString, ' is not a 32 bits integer ' ]
	"
	