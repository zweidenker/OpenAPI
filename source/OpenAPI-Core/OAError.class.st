Class {
	#name : 'OAError',
	#superclass : 'Error',
	#category : 'OpenAPI-Core-Errors',
	#package : 'OpenAPI-Core',
	#tag : 'Errors'
}

{ #category : 'accessing' }
OAError class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapAccessor: #typeLabel to: #error.
		mapping mapAccessor: #messageText to: #description ].

]

{ #category : 'as yet unclassified' }
OAError >> typeLabel [
	^ 'GenericError'
]
