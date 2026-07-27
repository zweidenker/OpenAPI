Class {
	#name : 'OAExample',
	#superclass : 'Object',
	#instVars : [
		'summary',
		'description',
		'value',
		'externalValue'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
OAExample class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( summary description value externalValue ) ].
	
]
