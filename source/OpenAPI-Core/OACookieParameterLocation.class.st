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
	for the same gap affecting 'in: #cookie' parameters. Unlike query parameters, a
	single Cookie header cannot repeat the same name for form+explode:true arrays -
	comma-join instead of passing the raw collection through (the spec leaves this
	combination undefined for cookies; this is the pragmatic, documented choice)."
	(self serializePairsFor: value name: key defaultStyle: 'form') do: [ :pair | | v |
		v := pair value.
		builder addCookieParameter: pair key value: (v isString
			ifTrue: [ v ]
			ifFalse: [ ',' join: v ]) ]
]
