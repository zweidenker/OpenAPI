Class {
	#name : 'OALink',
	#superclass : 'OABasicObject',
	#instVars : [
		'operationId',
		'operationRef',
		'parameters',
		'requestBody',
		'description',
		'server'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
OALink class >> neoJsonMapping: mapper [
	"operationId/operationRef are mutually exclusive per spec (not enforced here - that is
	OADocumentValidator/the meta-schema's job). parameters/requestBody/server are raw,
	passed-through JSON data (parameters values are runtime expression strings; requestBody
	is any; server is a plain Server Object with no dedicated OA* class in this codebase)."
	mapper for: self do: [ :mapping |
		mapping mapAccessors: #( operationId operationRef parameters requestBody description server ) ]
]

{ #category : 'accessing' }
OALink >> description [
	^ description
]

{ #category : 'accessing' }
OALink >> description: anObject [
	description := anObject
]

{ #category : 'accessing' }
OALink >> operationId [
	^ operationId
]

{ #category : 'accessing' }
OALink >> operationId: anObject [
	operationId := anObject
]

{ #category : 'accessing' }
OALink >> operationRef [
	^ operationRef
]

{ #category : 'accessing' }
OALink >> operationRef: anObject [
	operationRef := anObject
]

{ #category : 'accessing' }
OALink >> parameters [
	^ parameters
]

{ #category : 'accessing' }
OALink >> parameters: anObject [
	parameters := anObject
]

{ #category : 'accessing' }
OALink >> requestBody [
	^ requestBody
]

{ #category : 'accessing' }
OALink >> requestBody: anObject [
	requestBody := anObject
]

{ #category : 'accessing' }
OALink >> server [
	^ server
]

{ #category : 'accessing' }
OALink >> server: anObject [
	server := anObject
]
