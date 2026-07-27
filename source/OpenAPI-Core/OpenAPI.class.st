Class {
	#name : 'OpenAPI',
	#superclass : 'Object',
	#instVars : [
		'openapi',
		'info',
		'servers',
		'paths',
		'components',
		'security',
		'tags',
		'externalDocs'
	],
	#category : 'OpenAPI-Core',
	#package : 'OpenAPI-Core'
}

{ #category : 'reading' }
OpenAPI class >> fromString: aString [ 
	^ self readFrom: aString readStream 
]

{ #category : 'instance creation' }
OpenAPI class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapAccessors: #( openapi servers security tags externalDocs ).
		(mapping mapAccessor: #info) valueSchema: OAInfo.
		(mapping mapAccessor: #paths) valueSchema: #OAPaths.
		(mapping mapAccessor: #components) valueSchema: OAComponents ].
	mapper for: #OAPaths customDo: [ :mapping |
		mapping  mapWithValueSchema: OAPathItem ]
]

{ #category : 'instance creation' }
OpenAPI class >> readFrom: stream [
	^ ((NeoJSONReader on: stream)
		nextAs: self)
			prepare
]

{ #category : 'visiting' }
OpenAPI >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitOpenApi: self
]

{ #category : 'accessing' }
OpenAPI >> baseUrl [
	^ 'http://localhost:2376' asZnUrl 
]

{ #category : 'accessing' }
OpenAPI >> buildPaths [
	^ ((self class rootCallClass withAllSubclasses reject: #isAbstract) 
		collect: [ :each | each path -> each pathItem ]) asDictionary.
]

{ #category : 'accessing' }
OpenAPI >> componentAt: aString [ 
	^ components schemas at: aString
]

{ #category : 'accessing' }
OpenAPI >> components [
	^ components
]

{ #category : 'accessing' }
OpenAPI >> components: anObject [
	components := anObject
]

{ #category : 'as yet unclassified' }
OpenAPI >> consumePath: aReadStream [ 
	self shouldBeImplemented.
]

{ #category : 'accessing' }
OpenAPI >> externalDocs [
	^ externalDocs
]

{ #category : 'accessing' }
OpenAPI >> externalDocs: anObject [
	externalDocs := anObject
]

{ #category : 'accessing' }
OpenAPI >> info [
	^ info
]

{ #category : 'accessing' }
OpenAPI >> info: anObject [
	info := anObject
]

{ #category : 'as yet unclassified' }
OpenAPI >> lookupReference: aJSONSchemaReference [ 
	(aJSONSchemaReference isLocalPath) ifTrue: [ 
		"Transcript show: aJSONSchemaReference path; cr."
"		(aJSONSchemaReference path = '#/components/schemas/LinkGroupBean') ifTrue: [ 
			self halt ].
"		^ components schemas at: ($/ split: aJSONSchemaReference path) fourth ].
	Error signal: 'only local references are supported'
]

{ #category : 'accessing' }
OpenAPI >> openapi [
	^ openapi
]

{ #category : 'accessing' }
OpenAPI >> openapi: anObject [
	openapi := anObject
]

{ #category : 'as yet unclassified' }
OpenAPI >> operationWithId: aString [ 
	self paths do: [ :path |
		path implementedOperations 
			detect: [ :operation | operation operationId = aString ]
			ifFound: [ :operation | ^ operation  ] ].
	^ nil
]

{ #category : 'as yet unclassified' }
OpenAPI >> operationWithPath: aString [ 
	^ self paths at: aString
]

{ #category : 'as yet unclassified' }
OpenAPI >> pathForItem: aPathItem [
	^ paths keyAtValue: aPathItem 
]

{ #category : 'accessing' }
OpenAPI >> paths [
	^ paths ifNil: [ 
		paths := self buildPaths ]
]

{ #category : 'accessing' }
OpenAPI >> paths: anObject [
	paths := anObject.
	paths values do: [ :path | path api: self ]
]

{ #category : 'as yet unclassified' }
OpenAPI >> prepare [
	self resolveReferences
]

{ #category : 'printing' }
OpenAPI >> printOn: aStream [
	aStream << 'OpenAPI '.
	info ifNotNil: [ 
		info printOn: aStream  ]
]

{ #category : 'as yet unclassified' }
OpenAPI >> resolvePath: aString [ 
	| stream section |
	stream := aString readStream.
	self assert: (stream upTo: $/) = '#'.
	section := stream upTo: $/.
	(section = 'components') ifTrue: [ 
		^ components consumePath: stream  ].
	self halt.
]

{ #category : 'as yet unclassified' }
OpenAPI >> resolveReferences [
	^ OAReferenceResolveVisitor new 
		schemaRepository: self;
		resolve
]

{ #category : 'as yet unclassified' }
OpenAPI >> rootUrl [
	^ self baseUrl / self basePath
]

{ #category : 'accessing' }
OpenAPI >> security [
	^ security
]

{ #category : 'accessing' }
OpenAPI >> security: anObject [
	security := anObject
]

{ #category : 'accessing' }
OpenAPI >> servers [
	^ servers
]

{ #category : 'accessing' }
OpenAPI >> servers: anObject [
	servers := anObject
]

{ #category : 'as yet unclassified' }
OpenAPI >> specString [
	^ String streamContents: [ :stream |
		 self specStringOn: stream ]
]

{ #category : 'as yet unclassified' }
OpenAPI >> specStringOn: stream [
	^ (OAJSONWriter on: stream)
		prettyPrint: true;
		newLine: String crlf;
		nextPut: self
		
]

{ #category : 'accessing' }
OpenAPI >> tags [
	^ tags
]

{ #category : 'accessing' }
OpenAPI >> tags: anObject [
	tags := anObject
]
