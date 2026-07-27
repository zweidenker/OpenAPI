Class {
	#name : 'OAVisitor',
	#superclass : 'Object',
	#category : 'OpenAPI-Core',
	#package : 'OpenAPI-Core'
}

{ #category : 'as yet unclassified' }
OAVisitor >> processSchema: anOASchemaDefinition [ 
	^ JSONSchemaReferenceResolveVisitor new
		schemaRepository: self;
		read: anOASchemaDefinition 
]

{ #category : 'visiting' }
OAVisitor >> visit: object [
	object ifNil: [ ^ object ].
	object isString ifTrue: [ ^ object ].
	object isCollection ifTrue: [ ^ self visitAll: object ].
	(object isKindOf: Boolean) ifTrue: [ ^ object ]. 
	^ object acceptOpenApi: self 
]

{ #category : 'visting' }
OAVisitor >> visitAll: aCollection [ 
	aCollection ifNil: [ ^ nil ].
	^ aCollection collect: [ :each |
		self visit: each ]
]

{ #category : 'as yet unclassified' }
OAVisitor >> visitComponents: aComponents [ 
	^ aComponents
		schemas: (self visitAll: aComponents schemas);
		responses: (self visitAll: aComponents responses);
		parameters: (self visitAll: aComponents parameters);
		examples: (self visitAll: aComponents examples);
		requestBodies: (self visitAll: aComponents requestBodies);
		headers: (self visitAll: aComponents headers);
		securitySchemes: (self visitAll: aComponents securitySchemes);
		links: (self visitAll: aComponents links);
		callbacks: (self visitAll: aComponents callbacks);
		yourself 

]

{ #category : 'as yet unclassified' }
OAVisitor >> visitDictionary: aDictionary [
	 aDictionary ifNil: [ ^  nil ].
	^ aDictionary collect: [ :each | self visit: each ]
]

{ #category : 'as yet unclassified' }
OAVisitor >> visitHeader: aHeader [ 
	^ self visitParameter: aHeader
]

{ #category : 'as yet unclassified' }
OAVisitor >> visitInfo: aInfo [ 
	^ aInfo
]

{ #category : 'as yet unclassified' }
OAVisitor >> visitJSONSchema: aSchema [ 
	^ JSONSchemaReferenceResolveVisitor new
		schemaRepository: self;
		read: aSchema
]

{ #category : 'visiting' }
OAVisitor >> visitMediaTypeObject: aMediaTypeObject [ 

	^ aMediaTypeObject
		schema: (self processSchema: aMediaTypeObject schema);
		yourself.

]

{ #category : 'as yet unclassified' }
OAVisitor >> visitOpenApi: anApi [
	^ anApi
		info: (self visit: anApi info);
		servers: (self visitAll: anApi  servers);
		paths: (self visitAll: anApi paths);
		components: (self visit: anApi components);
		security: (self visit: anApi security);
		tags: (self visitAll: anApi tags);
		externalDocs: (self visit: anApi externalDocs);
		yourself
]

{ #category : 'as yet unclassified' }
OAVisitor >> visitOpenApiSchemaDefinition: anOASchemaDefinition [ 
	^ anOASchemaDefinition isReference 
		ifTrue: [ self visit: anOASchemaDefinition reference ]
		ifFalse: [ self processSchema: anOASchemaDefinition ]
]

{ #category : 'as yet unclassified' }
OAVisitor >> visitOperation: anOperation [ 
	^ anOperation
		requestBody: (self visit: anOperation requestBody);
		parameters: (self visitAll: anOperation parameters);
		responses: (self visitAll: anOperation responses);
		yourself

]

{ #category : 'vistiting' }
OAVisitor >> visitParameter: aParameter [ 
	^ aParameter 
		schema: (self processSchema: aParameter schema);
		examples: (self visitAll: aParameter examples);
		content: (self visit: aParameter content);
		yourself
]

{ #category : 'as yet unclassified' }
OAVisitor >> visitPathItem: aPathItem [ 
	aPathItem implementedMethods do: [ :method |
		aPathItem instVarNamed: method put: (self visit: (aPathItem perform: method))  ]. 
	^ aPathItem 
]

{ #category : 'visiting' }
OAVisitor >> visitReference: aReference [ 
	^ aReference 
]

{ #category : 'visiting' }
OAVisitor >> visitRequestBody: aRequestBody [ 
	^ aRequestBody 
		content: (self visit: aRequestBody content);
		yourself
]

{ #category : 'visting' }
OAVisitor >> visitResponse: aResponse [ 
	^ aResponse
		headers: (self visitAll: aResponse headers);
		content: (self visitDictionary: aResponse content );
		yourself
]

{ #category : 'visting' }
OAVisitor >> visitSchemaDefinition: aSchema [ 
	^ JSONSchemaVisitor new
		visit: aSchema;
		schema
]
