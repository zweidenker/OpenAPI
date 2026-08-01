Class {
	#name : 'OACookieParameterLocation',
	#superclass : 'OAParameterLocation',
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'writing' }
OACookieParameterLocation >> write: key value: value to: builder [
	"Previously missing entirely - see OAHeaderParametersLocation>>write:value:to:
	for the same gap affecting 'in: #cookie' parameters."
	builder addCookieParameter: key value: value
]
