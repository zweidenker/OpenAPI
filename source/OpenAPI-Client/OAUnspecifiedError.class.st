Class {
	#name : 'OAUnspecifiedError',
	#superclass : 'Error',
	#instVars : [
		'contents',
		'response'
	],
	#category : 'OpenAPI-Client',
	#package : 'OpenAPI-Client'
}

{ #category : 'accessing' }
OAUnspecifiedError >> contents [
	^ contents
]

{ #category : 'accessing' }
OAUnspecifiedError >> contents: anObject [
	contents := anObject
]

{ #category : 'accessing' }
OAUnspecifiedError >> response [
	^ response
]

{ #category : 'accessing' }
OAUnspecifiedError >> response: anObject [
	response := anObject
]
