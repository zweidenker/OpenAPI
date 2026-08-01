Class {
	#name : 'OAHeaderParametersLocation',
	#superclass : 'OAParameterLocation',
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'reading' }
OAHeaderParametersLocation >> extractParameter: aCall [
	^ parameter read: (aCall request headers at: parameter name ifAbsent: [ ^ nil ])
]

{ #category : 'writing' }
OAHeaderParametersLocation >> write: key value: value to: builder [
	"Previously missing entirely: OAOperation>>applyParameters:builder: -> OAParameter>>
	copyFrom:to: dispatches here for any 'in: #header' parameter, and crashed with
	#doesNotUnderstand: #write:value:to: for every client request using a header
	parameter (e.g. an API key sent via a custom header)."
	| pairs |
	pairs := self serializePairsFor: value name: key defaultStyle: 'simple'.
	builder addHeaderParameter: key value: pairs first value
]
