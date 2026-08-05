Class {
	#name : 'OAReferenceResolveVisitor',
	#superclass : 'OAVisitor',
	#instVars : [
		'schemaRepository',
		'schemasByPath',
		'seen'
	],
	#category : 'OpenAPI-Core',
	#package : 'OpenAPI-Core'
}

{ #category : 'initialization' }
OAReferenceResolveVisitor >> initialize [ 
	super initialize.
	schemasByPath := Dictionary new.
	seen := Set new.
]

{ #category : 'as yet unclassified' }
OAReferenceResolveVisitor >> resolve [
	^ self visit: schemaRepository 
]

{ #category : 'initialization' }
OAReferenceResolveVisitor >> resolveReference: aReference continueOn: aVisitor [
	| schema |
	schemasByPath 
		at: aReference path
		ifPresent: [ :value | ^ value ].

	schema := (schemaRepository lookupReference: aReference) asJSONSchema.
	schemasByPath
		at: aReference path
		put: schema.
	aVisitor visit: schema.
	^ schema
]

{ #category : 'accessing' }
OAReferenceResolveVisitor >> schemaRepository: anObject [
	schemaRepository := anObject
]

{ #category : 'visiting' }
OAReferenceResolveVisitor >> visit: anObject [
	(seen includes: anObject) 
		ifTrue: [ ^ anObject ].
	seen add: anObject.
	^ super visit: anObject
]

{ #category : 'as yet unclassified' }
OAReferenceResolveVisitor >> visitOpenApi: anApi [
	"components is optional per spec; a document without it (or without components.schemas) has nothing to resolve here."
	| visitor |
	visitor := JSONSchemaReferenceResolveVisitor new
			schemaRepository: self.
	(anApi components notNil and: [ anApi components schemas notNil ]) ifTrue: [
		anApi components schemas: (anApi components schemas collect: #asJSONSchema).
		anApi components schemas: (anApi components schemas collect: [ :definition |
			 visitor read: definition ]) ].
	^ super visitOpenApi: anApi
]

{ #category : 'as yet unclassified' }
OAReferenceResolveVisitor >> visitOpenApiSchemaDefinition: anOASchemaDefinition [ 
	^ anOASchemaDefinition isReference 
		ifTrue: [ self visit: anOASchemaDefinition reference ]
		ifFalse: [ self processSchema: anOASchemaDefinition ]
]

{ #category : 'visiting' }
OAReferenceResolveVisitor >> visitReference: aReference [
	^ schemaRepository lookupReference: aReference
]
