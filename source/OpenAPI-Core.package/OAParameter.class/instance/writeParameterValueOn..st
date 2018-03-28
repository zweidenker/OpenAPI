writing
writeParameterValueOn: anObject
	| value |
	self flag: #todo.
	"needs to be improved for required or not. If not required we don't write the
	value. Needs to be checked if that constraint is ok"
	value := self extractParameter: anObject. 
	value ifNil: [ ^ self ].
	self shouldUseAccessors 
		ifTrue: [ anObject perform: name asSymbol asMutator with: value ]
		ifFalse: [ anObject instVarNamed: name put: value ]