Class {
	#name : 'OAContact',
	#superclass : 'Object',
	#instVars : [
		'name',
		'url',
		'email'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
OAContact class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( name url email ) ]
]

{ #category : 'accessing' }
OAContact >> email [
	^ email
]

{ #category : 'accessing' }
OAContact >> email: anObject [
	email := anObject
]

{ #category : 'accessing' }
OAContact >> name [
	^ name
]

{ #category : 'accessing' }
OAContact >> name: anObject [
	name := anObject
]

{ #category : 'accessing' }
OAContact >> url [
	^ url
]

{ #category : 'accessing' }
OAContact >> url: anObject [
	url := anObject
]
