visiting
visit: object
	object ifNil: [ ^ object ].
	object isString ifTrue: [ ^ object ].
	object isCollection ifTrue: [ ^ self visitAll: object ].
	(object isKindOf: Boolean) ifTrue: [ ^ object ]. 
	^ object acceptOpenApi: self 