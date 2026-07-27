Class {
	#name : 'OAParameterLocation',
	#superclass : 'Object',
	#instVars : [
		'parameter'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
OAParameterLocation class >> of: anOAParameter [
	^ self new
		parameter: anOAParameter;
		yourself.
]

{ #category : 'as yet unclassified' }
OAParameterLocation >> extractParameter: aCall [
	self shouldBeImplemented.
]

{ #category : 'accessing' }
OAParameterLocation >> parameter: anOAParameter [
	parameter := anOAParameter.
]

{ #category : 'accessing' }
OAParameterLocation >> parameterName [
	^ parameter name.
]

{ #category : 'accessing' }
OAParameterLocation >> parameterSchema [
	^ parameter schema.
]
