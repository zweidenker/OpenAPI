Class {
	#name : 'OAPathParameterLocation',
	#superclass : 'OAParameterLocation',
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'reading' }
OAPathParameterLocation >> extractParameter: aCall [
	| index value |
	($/ split: aCall class path allButFirst) withIndexDo: [ :each :idx |
		(each allButFirst allButLast = self parameterName ) ifTrue: [ 
			index := idx ] ].
	value := aCall request uri pathSegments at: index.
	^ parameter read: value.

]

{ #category : 'writing' }
OAPathParameterLocation >> write: key value: value to: builder [ 
	builder addPathParameter: key value: value
]
