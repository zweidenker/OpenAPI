Class {
	#name : 'OASchemaDefinition',
	#superclass : 'JSONSchemaDefinition',
	#instVars : [
		'default',
		'nullable'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
OASchemaDefinition class >> neoJsonMapping: mapper [
	super neoJsonMapping: mapper.
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( default nullable )  ]
]

{ #category : 'visiting' }
OASchemaDefinition >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitOpenApiSchemaDefinition: self
]

{ #category : 'accessing' }
OASchemaDefinition >> default [
	^ default
]

{ #category : 'accessing' }
OASchemaDefinition >> default: anObject [
	default := anObject
]

{ #category : 'accessing' }
OASchemaDefinition >> nullable [
	^ nullable
]

{ #category : 'accessing' }
OASchemaDefinition >> nullable: aBoolean [
	nullable := aBoolean
]
