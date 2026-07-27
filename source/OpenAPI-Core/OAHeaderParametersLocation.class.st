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
