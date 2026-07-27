Class {
	#name : 'OpenAPIObject',
	#superclass : 'Object',
	#instVars : [
		'operations',
		'api'
	],
	#category : 'OpenAPI-Core',
	#package : 'OpenAPI-Core'
}

{ #category : 'accessing' }
OpenAPIObject >> api: anOpenAPI [ 
	api := anOpenAPI 
]

{ #category : 'as yet unclassified' }
OpenAPIObject >> methodAt: anOperation [ 
	^ operations keyAtValue: anOperation 
]

{ #category : 'as yet unclassified' }
OpenAPIObject >> operationAt: aString put: anOperation [ 
	self operations 
		at: aString
		put: anOperation
]

{ #category : 'as yet unclassified' }
OpenAPIObject >> operationIds [
	^ operations values collect: #id
]

{ #category : 'as yet unclassified' }
OpenAPIObject >> operationWithId: aString [ 
	^ operations 
		detect: [ :each | each id = aString ]
		ifNone: [ nil ]
]

{ #category : 'accessing' }
OpenAPIObject >> operations [
	^ operations ifNil: [ 
		operations := Dictionary new ]
]
