Class {
	#name : 'OAMediaTypeObject',
	#superclass : 'OABasicObject',
	#instVars : [
		'schema',
		'example',
		'examples',
		'encoding',
		'response'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
OAMediaTypeObject class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapAccessors: #( encoding ).
		(mapping mapAccessor: #schema) valueSchema: OASchemaDefinition.
		(mapping mapAccessor: #example) valueSchema: OAExample.
		(mapping mapAccessor: #examples) valueSchema: #OAExamples ].
	mapper for: #OAExamples customDo: [ :mapping |
		mapping  mapWithValueSchema: OAExample ]	
]

{ #category : 'visting' }
OAMediaTypeObject >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitMediaTypeObject: self
]

{ #category : 'as yet unclassified' }
OAMediaTypeObject >> api [
	^ response api
]

{ #category : 'accessing' }
OAMediaTypeObject >> encoding [
	^ encoding
]

{ #category : 'accessing' }
OAMediaTypeObject >> encoding: aDictionary [
	encoding := aDictionary
]

{ #category : 'as yet unclassified' }
OAMediaTypeObject >> example [
	^ example
]

{ #category : 'as yet unclassified' }
OAMediaTypeObject >> examples [
	^ examples
]

{ #category : 'accessing' }
OAMediaTypeObject >> examples: aCollection [ 
	examples := aCollection
]

{ #category : 'as yet unclassified' }
OAMediaTypeObject >> handleResponse: aString [ 
	^ schema readString: aString
]

{ #category : 'as yet unclassified' }
OAMediaTypeObject >> read: aString [ 
	^ schema readString: aString
]

{ #category : 'as yet unclassified' }
OAMediaTypeObject >> read: value object: object [
	^ [schema read: value object: object] on: JSONSchemaError do: [ :ex |
			OAInvalidFormat signal: ex description
		 ]
]

{ #category : 'as yet unclassified' }
OAMediaTypeObject >> resolvePath: aString [ 
	^ self api resolvePath: aString
]

{ #category : 'as yet unclassified' }
OAMediaTypeObject >> response [
	^ response
]

{ #category : 'as yet unclassified' }
OAMediaTypeObject >> response: aResponse [ 
	response := aResponse 
]

{ #category : 'accessing' }
OAMediaTypeObject >> schema [
	^ schema
]

{ #category : 'accessing' }
OAMediaTypeObject >> schema: anOASchema [ 
	schema := anOASchema
]

{ #category : 'as yet unclassified' }
OAMediaTypeObject >> write: anObject [
	^ schema write: anObject
]

{ #category : 'as yet unclassified' }
OAMediaTypeObject >> writeBody: aDictionary builder: builder [ 
	builder addJSONBody: (schema isAnyObject 
		ifTrue: [ aDictionary ]
		ifFalse: [ schema readObject: aDictionary ])

]

{ #category : 'as yet unclassified' }
OAMediaTypeObject >> writeFormBody: aDictionary builder: builder [
	builder addFormBody: (schema isAnyObject
		ifTrue: [ aDictionary ]
		ifFalse: [ schema readObject: aDictionary ])
]
