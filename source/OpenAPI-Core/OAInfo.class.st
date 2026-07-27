Class {
	#name : 'OAInfo',
	#superclass : 'Object',
	#instVars : [
		'title',
		'description',
		'termsOfService',
		'contact',
		'license',
		'version'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
OAInfo class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( title description termsOfService version ).
		(mapping mapInstVar: #contact) valueSchema: OAContact.
		(mapping mapInstVar: #license) valueSchema: OALicense ]
]

{ #category : 'as yet unclassified' }
OAInfo >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitInfo: self
]

{ #category : 'accessing' }
OAInfo >> contact [
	^ contact
]

{ #category : 'accessing' }
OAInfo >> contact: anObject [
	contact := anObject
]

{ #category : 'accessing' }
OAInfo >> description [
	^ description
]

{ #category : 'accessing' }
OAInfo >> description: anObject [
	description := anObject
]

{ #category : 'accessing' }
OAInfo >> license [
	^ license
]

{ #category : 'accessing' }
OAInfo >> license: anObject [
	license := anObject
]

{ #category : 'printing' }
OAInfo >> printOn: aStream [ 
	aStream << title  << ' (' << version << ')'
]

{ #category : 'accessing' }
OAInfo >> termsOfService [
	^ termsOfService
]

{ #category : 'accessing' }
OAInfo >> termsOfService: anObject [
	termsOfService := anObject
]

{ #category : 'accessing' }
OAInfo >> title [
	^ title
]

{ #category : 'accessing' }
OAInfo >> title: anObject [
	title := anObject
]

{ #category : 'accessing' }
OAInfo >> version [
	^ version
]

{ #category : 'accessing' }
OAInfo >> version: anObject [
	version := anObject
]
