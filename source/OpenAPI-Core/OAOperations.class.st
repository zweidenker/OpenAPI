Class {
	#name : 'OAOperations',
	#superclass : 'Object',
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
OAOperations class >> neoJsonMapping: mapper [
	mapper for: self customDo: [ :mapping |
		mapping mapWithValueSchema:  OAPathItem ].
]
