Class {
	#name : 'OAQueryParameterLocation',
	#superclass : 'OAParameterLocation',
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
OAQueryParameterLocation >> extractParameter: aCall [
	| value |
	value := aCall request uri 
		queryAt: self parameterName
		ifPresent: [ :val | self parameterSchema readString: val ].
		
	"
	required ifTrue: [ 
		OAMissingRequiredParameter signal: 'parameter ', name, ' is required but not present' ].
	"
	"value ifNil: [self halt]."
	^ value
	
	
]

{ #category : 'as yet unclassified' }
OAQueryParameterLocation >> write: key value: value to: builder [ 
	builder addQueryParameter: key value: value
]
