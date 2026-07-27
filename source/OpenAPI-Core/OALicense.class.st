Class {
	#name : 'OALicense',
	#superclass : 'Object',
	#instVars : [
		'name',
		'url'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'mapping' }
OALicense class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( name url ) ].
]

{ #category : 'accessing' }
OALicense >> name [
	^ name
]

{ #category : 'accessing' }
OALicense >> name: anObject [
	name := anObject
]

{ #category : 'accessing' }
OALicense >> url [
	^ url
]

{ #category : 'accessing' }
OALicense >> url: anObject [
	url := anObject
]
