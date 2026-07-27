Class {
	#name : 'OAPathItem',
	#superclass : 'Object',
	#instVars : [
		'api',
		'summary',
		'description',
		'get',
		'put',
		'post',
		'delete',
		'options',
		'head',
		'patch',
		'trace',
		'servers'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
OAPathItem class >> neoJsonMapping: mapper [
	mapper
		for: self
		do: [ :mapping | 
			mapping mapInstVars: #(summary description servers).
			(mapping mapAccessors: #(get put post delete options head patch trace))
				do: [ :each | each valueSchema: OAOperation. ]. ].
]

{ #category : 'as yet unclassified' }
OAPathItem >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitPathItem: self
]

{ #category : 'as yet unclassified' }
OAPathItem >> api [
	^ api
]

{ #category : 'accessing' }
OAPathItem >> api: anObject [
	api := anObject
]

{ #category : 'accessing' }
OAPathItem >> definedOperationNames [
	^ (self methods intersection: self class instVarNames)
		reject: [ :each | (self instVarNamed: each) isNil. ].
]

{ #category : 'accessing' }
OAPathItem >> delete [
	^ delete
]

{ #category : 'accessing' }
OAPathItem >> delete: anOperation [
	anOperation pathItem: self.
	delete := anOperation
]

{ #category : 'accessing' }
OAPathItem >> description [
	^ description
]

{ #category : 'accessing' }
OAPathItem >> description: anObject [
	description := anObject
]

{ #category : 'accessing' }
OAPathItem >> get [
	^ get
]

{ #category : 'accessing' }
OAPathItem >> get: anOperation [
	anOperation pathItem: self.
	get := anOperation 
]

{ #category : 'accessing' }
OAPathItem >> head [
	^ head
]

{ #category : 'accessing' }
OAPathItem >> head: anOperation [
	anOperation pathItem: self.
	head := anOperation 
]

{ #category : 'printing' }
OAPathItem >> implementedMethods [
	^ (self methods intersection: self class instVarNames) 
		reject: [:each | (self instVarNamed: each) isNil ]

]

{ #category : 'as yet unclassified' }
OAPathItem >> implementedMethodsIn: aClass [ 
	^ self methods select: [ :method |  aClass includesSelector: method asSymbol ]
]

{ #category : 'as yet unclassified' }
OAPathItem >> implementedOperations [
	^ self implementedMethods collect: [ :each |
		self operationAt: each ]
]

{ #category : 'accessing' }
OAPathItem >> methodForOperation: anOperation [ 
	self methods do: [ :method |
		((self instVarNamed: method) = anOperation) ifTrue: [ 
			^ method ] ].
	^ nil
]

{ #category : 'accessing' }
OAPathItem >> methods [
	^ #( get put post delete options head patch trace )
]

{ #category : 'as yet unclassified' }
OAPathItem >> operationAt: aSymbol [
	^ (self instVarNamed: aSymbol) ifNil: [ 
		self instVarNamed: aSymbol put: OAOperation new ]
]

{ #category : 'accessing' }
OAPathItem >> options [
	^ options
]

{ #category : 'accessing' }
OAPathItem >> options: anOperation [
	anOperation pathItem: self.
	options := anOperation 
]

{ #category : 'accessing' }
OAPathItem >> patch [
	^ patch
]

{ #category : 'accessing' }
OAPathItem >> patch: anOperation [
	anOperation pathItem: self.
	patch := anOperation 
]

{ #category : 'accessing' }
OAPathItem >> path [
	^ api pathForItem: self 
]

{ #category : 'accessing' }
OAPathItem >> post [
	^ post
]

{ #category : 'accessing' }
OAPathItem >> post: anOperation [
	anOperation pathItem: self.
	post := anOperation 
]

{ #category : 'printing' }
OAPathItem >> printOn: stream [
	stream
		<< 'path item: ' << (api pathForItem: self) << ', '
		<< 'methods: ' 
		<< ($, join: self implementedMethods)

]

{ #category : 'accessing' }
OAPathItem >> put [
	^ put
]

{ #category : 'accessing' }
OAPathItem >> put: anOperation [
	anOperation pathItem: self.
	put := anOperation 
]

{ #category : 'accessing' }
OAPathItem >> servers [
	^ servers
]

{ #category : 'accessing' }
OAPathItem >> servers: anObject [
	servers := anObject
]

{ #category : 'accessing' }
OAPathItem >> summary [
	^ summary
]

{ #category : 'accessing' }
OAPathItem >> summary: anObject [
	summary := anObject
]

{ #category : 'accessing' }
OAPathItem >> trace [
	^ trace
]

{ #category : 'accessing' }
OAPathItem >> trace: anOperation [
	anOperation pathItem: self.
	trace := anOperation 
]
