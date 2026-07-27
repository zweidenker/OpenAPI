Class {
	#name : 'OpenAPIUriSpace',
	#superclass : 'ZnRestUriSpace',
	#instVars : [
		'rootClass'
	],
	#category : 'OpenAPI-REST',
	#package : 'OpenAPI-REST'
}

{ #category : 'public' }
OpenAPIUriSpace >> match: request [
	(rootClass allSubclasses reject: #isAbstract)
		do: [ :callClass |
			(callClass match: request) ifTrue: [ 
				^ callClass new ] ].
	^ nil
		
]

{ #category : 'accessing' }
OpenAPIUriSpace >> rootClass [
	^ rootClass
]

{ #category : 'accessing' }
OpenAPIUriSpace >> rootClass: anObject [
	rootClass := anObject
]
