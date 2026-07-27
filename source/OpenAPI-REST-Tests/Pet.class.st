Class {
	#name : 'Pet',
	#superclass : 'Object',
	#instVars : [
		'id',
		'name',
		'age'
	],
	#classInstVars : [
		'instances'
	],
	#category : 'OpenAPI-REST-Tests',
	#package : 'OpenAPI-REST-Tests'
}

{ #category : 'accessing' }
Pet class >> instanceWithId: aNumber [
	^ self instances 
		detect: [ :each | each id = aNumber ]
		ifNone: [ nil ]
]

{ #category : 'accessing' }
Pet class >> instances [
	^ instances ifNil: [ 
		instances := IdentitySet new ]
]

{ #category : 'accessing' }
Pet class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( id name age ) ]
]

{ #category : 'as yet unclassified' }
Pet class >> resetInstances [
	instances := nil
]

{ #category : 'accessing' }
Pet >> age [
	^ age
]

{ #category : 'accessing' }
Pet >> age: anInteger [ 
	age := anInteger
]

{ #category : 'accessing' }
Pet >> id [ 
	^ id ifNil: [ 
		id := self class instances size + 1 ]
]

{ #category : 'accessing' }
Pet >> id: anInteger [ 
	id := anInteger
]

{ #category : 'accessing' }
Pet >> name [
	^ name
]

{ #category : 'accessing' }
Pet >> name: aString [ 
	name := aString
]

{ #category : 'storing' }
Pet >> store [
	^ self class instances add: self
]
