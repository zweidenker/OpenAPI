Class {
	#name : 'OAUnspecifiedResponse',
	#superclass : 'Object',
	#instVars : [
		'response'
	],
	#category : 'OpenAPI-Client',
	#package : 'OpenAPI-Client'
}

{ #category : 'converting' }
OAUnspecifiedResponse >> asString [ 
	^ response contents
]

{ #category : 'as yet unclassified' }
OAUnspecifiedResponse >> contents [
	^ response contents
]

{ #category : 'accessing' }
OAUnspecifiedResponse >> response [
	^ response
]

{ #category : 'accessing' }
OAUnspecifiedResponse >> response: anObject [
	response := anObject
]
