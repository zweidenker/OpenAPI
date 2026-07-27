Class {
	#name : 'OpenAPIOperation',
	#superclass : 'Object',
	#instVars : [
		'id',
		'object'
	],
	#category : 'OpenAPI-Core',
	#package : 'OpenAPI-Core'
}

{ #category : 'accessing' }
OpenAPIOperation >> id [
	^ id
]

{ #category : 'accessing' }
OpenAPIOperation >> id: aString [ 
	id := aString
]

{ #category : 'as yet unclassified' }
OpenAPIOperation >> method [
	^ object methodAt: self
]

{ #category : 'accessing' }
OpenAPIOperation >> object [
	^ object
]

{ #category : 'accessing' }
OpenAPIOperation >> object: anObject [ 
	object := anObject
]

{ #category : 'accessing' }
OpenAPIOperation >> url [
	self shouldBeImplemented.
]
