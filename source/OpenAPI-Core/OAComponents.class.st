Class {
	#name : 'OAComponents',
	#superclass : 'OABasicObject',
	#instVars : [
		'schemas',
		'responses',
		'parameters',
		'examples',
		'requestBodies',
		'headers',
		'securitySchemes',
		'links',
		'callbacks'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
OAComponents class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapAccessors: #( parameters examples headers securitySchemes links callbacks ).
		(mapping mapAccessor: #schemas) valueSchema: #OASchemas.
		(mapping mapInstVar: #parameters) valueSchema: #Parameters.
		(mapping mapInstVar: #requestBodies) valueSchema: #RequestBodies.
		self flag: #todo.
		"Response object needs to be done. https://github.com/zweidenker/OpenAPI/issues/3"
		(mapping mapAccessor: #responses) "valueSchema: #OAResponses".
		"(mapping mapAccessor: #example) valueSchema: OAExample."
		(mapping mapAccessor: #examples) valueSchema: #OAExamples ].
	mapper for: #OASchemas customDo: [ :mapping |
		mapping  mapWithValueSchema: OASchemaDefinition ].  
	mapper for: #OAExamples customDo: [ :mapping |
		mapping  mapWithValueSchema: OAExample ].  
	mapper for: #Parameters customDo: [ :mapping |
		mapping mapWithValueSchema: OAParameter ].
	mapper for: #RequestBodies customDo: [ :mapping |
		mapping mapWithValueSchema: OARequestBody  ]
]

{ #category : 'as yet unclassified' }
OAComponents >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitComponents: self 
]

{ #category : 'as yet unclassified' }
OAComponents >> callbacks [
	^ callbacks
]

{ #category : 'accessing' }
OAComponents >> callbacks: anObject [
	callbacks := anObject
]

{ #category : 'as yet unclassified' }
OAComponents >> consumePath: aStream [ 
	| type |
	type := aStream upTo: $/.
	(type = 'schemas') ifTrue: [ 
		^ schemas at: aStream upToEnd ].
	self halt.
]

{ #category : 'as yet unclassified' }
OAComponents >> examples [
	^ examples
]

{ #category : 'accessing' }
OAComponents >> examples: anObject [
	examples := anObject
]

{ #category : 'as yet unclassified' }
OAComponents >> headers [
	^ headers
]

{ #category : 'accessing' }
OAComponents >> headers: anObject [
	headers := anObject
]

{ #category : 'as yet unclassified' }
OAComponents >> links [
	^ links
]

{ #category : 'accessing' }
OAComponents >> links: anObject [
	links := anObject
]

{ #category : 'as yet unclassified' }
OAComponents >> parameters [
	^ parameters
]

{ #category : 'accessing' }
OAComponents >> parameters: aCollection [ 
	parameters := aCollection
]

{ #category : 'as yet unclassified' }
OAComponents >> requestBodies [
	^ requestBodies
]

{ #category : 'accessing' }
OAComponents >> requestBodies: anObject [
	requestBodies := anObject
]

{ #category : 'as yet unclassified' }
OAComponents >> resolveSchema: aString [ 
	self shouldBeImplemented.
]

{ #category : 'as yet unclassified' }
OAComponents >> responses [
	^ responses
]

{ #category : 'accessing' }
OAComponents >> responses: aCollection [ 
	responses := aCollection
]

{ #category : 'as yet unclassified' }
OAComponents >> schemas [
	^ schemas
]

{ #category : 'accessing' }
OAComponents >> schemas: aCollection [ 
	schemas := aCollection
]

{ #category : 'as yet unclassified' }
OAComponents >> securitySchemes [
	^ securitySchemes
]

{ #category : 'accessing' }
OAComponents >> securitySchemes: aCollection [ 
	securitySchemes := aCollection
]
