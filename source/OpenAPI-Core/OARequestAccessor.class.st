Class {
	#name : 'OARequestAccessor',
	#superclass : 'Object',
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
OARequestAccessor class >> label [
	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
OARequestAccessor class >> withLabel: aString [ 
	^ (self allSubclasses reject: #isAbstract)
		detect: [ :each | each label = aString ]
]
