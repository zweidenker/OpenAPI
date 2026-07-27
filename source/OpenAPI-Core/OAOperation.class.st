Class {
	#name : 'OAOperation',
	#superclass : 'Object',
	#instVars : [
		'pathItem',
		'tags',
		'summary',
		'description',
		'externalDocs',
		'operationId',
		'parameters',
		'requestBody',
		'responses',
		'callbacks',
		'deprecated',
		'security',
		'servers'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
OAOperation class >> neoJsonMapping: mapper [
	mapper
		for: self
		do: [ :mapping | 
			mapping mapInstVars: #(tags summary description externalDocs operationId responses callbacks deprecated security servers).
			(mapping mapAccessor: #parametersSortedByName mutator: #parameters: to: #parameters) valueSchema: #ParameterList.
			(mapping mapInstVar: #requestBody) valueSchema: OARequestBody.
			(mapping mapAccessor: #responses) valueSchema: #ResponsesDictionary. ].
	mapper
		for: #ParameterList customDo: [ :mapping | mapping listOfElementSchema: OAParameter. ];
		for: #ResponsesDictionary customDo: [ :mapping | mapping mapWithValueSchema: OAResponse. ].
]

{ #category : 'visting' }
OAOperation >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitOperation: self
]

{ #category : 'as yet unclassified' }
OAOperation >> addParameters: aCollection [ 
	parameters ifNil: [ parameters := OrderedCollection new ].
	parameters addAll: aCollection
]

{ #category : 'as yet unclassified' }
OAOperation >> api [
	^ pathItem api
]

{ #category : 'as yet unclassified' }
OAOperation >> applyBody: body builder: builder [ 
	self hasBody ifTrue: [  | mediaTypeObject |
		body ifNil: [ Error signal: 'cannot use nil for body' ].
		mediaTypeObject := self mediaTypeObjectFor: 'application/json'.
		mediaTypeObject writeBody: body builder: builder ] 
]

{ #category : 'as yet unclassified' }
OAOperation >> applyParameters: aCollection builder: aBuilder [ 
	parameters isNil ifTrue: [ ^ self ].
	parameters do: [ :parameter |
		 parameter copyFrom: aCollection asDictionary to: aBuilder ]
]

{ #category : 'accessing' }
OAOperation >> callbacks [
	^ callbacks
]

{ #category : 'accessing' }
OAOperation >> callbacks: anObject [
	callbacks := anObject
]

{ #category : 'accessing' }
OAOperation >> deprecated [
	^ deprecated
]

{ #category : 'accessing' }
OAOperation >> description [
	^ description
]

{ #category : 'accessing' }
OAOperation >> description: anObject [
	description := anObject
]

{ #category : 'accessing' }
OAOperation >> externalDocs [
	^ externalDocs
]

{ #category : 'accessing' }
OAOperation >> externalDocs: anObject [
	externalDocs := anObject
]

{ #category : 'as yet unclassified' }
OAOperation >> handleResponse: aResponse [ 
	responses ifNil: [ 
		^ OAUnspecifiedResponse new
			response: aResponse ].
	^ responses 
		at: aResponse status asString
		ifPresent: [ :response |  response handleResponse: aResponse ]
		ifAbsent: [ 
			OAUnspecifiedResponse new
				response: aResponse ].

]

{ #category : 'testing' }
OAOperation >> hasBody [
	^ requestBody notNil
]

{ #category : 'reading' }
OAOperation >> initializeValuesOn: aCall fromRequest: request [
	parameters ifNotNil: [
		parameters do: [ :each | 
			each 
				writeParameterValueOn: aCall parameterValueDelegate 
				request: request]].
	requestBody ifNotNil: [ 
		(requestBody 
			readFrom: request 
			object: aCall bodyValueDelegate ) ]

]

{ #category : 'accessing' }
OAOperation >> mediaTypeObjectFor: aString [ 
	^ requestBody contentAt: aString
]

{ #category : 'as yet unclassified' }
OAOperation >> method [
	^ pathItem methodForOperation: self
]

{ #category : 'accessing' }
OAOperation >> operationId [
	^ operationId
]

{ #category : 'accessing' }
OAOperation >> operationId: anObject [
	operationId := anObject
]

{ #category : 'as yet unclassified' }
OAOperation >> parameterWithName: aString [ 
	^ parameters detect: [ :each | each name = aString ]
]

{ #category : 'as yet unclassified' }
OAOperation >> parameterWithName: aString ifFound: aBlock [
	^ parameters 
		detect: [ :each | each name = aString ]
		ifFound: [ :v | aBlock value: v ]
]

{ #category : 'accessing' }
OAOperation >> parameters [
	^ parameters
]

{ #category : 'accessing' }
OAOperation >> parameters: anObject [
	parameters := anObject
]

{ #category : 'accessing' }
OAOperation >> parametersSortedByName [
	parameters ifNil: [ ^ nil ].
	^ parameters sorted: [ :a :b | a name < b name ]
]

{ #category : 'accessing' }
OAOperation >> path [
	^ pathItem path
]

{ #category : 'accessing' }
OAOperation >> pathItem: anObject [
	pathItem := anObject
]

{ #category : 'as yet unclassified' }
OAOperation >> prepareBuilder: builder [
	builder method: self method asUppercase 
]

{ #category : 'printing' }
OAOperation >> printOn: stream [
	stream << summary asString << ': '<< description asString
]

{ #category : 'accessing' }
OAOperation >> requestBody [
	^ requestBody
]

{ #category : 'accessing' }
OAOperation >> requestBody: anObject [
	requestBody := anObject
]

{ #category : 'as yet unclassified' }
OAOperation >> response: anObject status: statusCode contentType: contentType [
	^ (ZnResponse statusCode: statusCode) 
		entity: ((responses at: statusCode) response: anObject contentType: contentType);
		yourself

]

{ #category : 'responses' }
OAOperation >> responseAt: aString [ 
	^ responses at: aString
]

{ #category : 'accessing' }
OAOperation >> responses [
	^ responses
]

{ #category : 'accessing' }
OAOperation >> responses: aDictionary [
	aDictionary ifNil: [ ^ self ].
	aDictionary values do: [ :each | each operation: self ].
	responses := aDictionary
]

{ #category : 'accessing' }
OAOperation >> security [
	^ security
]

{ #category : 'accessing' }
OAOperation >> security: anObject [
	security := anObject
]

{ #category : 'accessing' }
OAOperation >> servers [
	^ servers
]

{ #category : 'accessing' }
OAOperation >> servers: anObject [
	servers := anObject
]

{ #category : 'accessing' }
OAOperation >> summary [
	^ summary
]

{ #category : 'accessing' }
OAOperation >> summary: anObject [
	summary := anObject
]

{ #category : 'accessing' }
OAOperation >> tags [
	^ tags
]

{ #category : 'accessing' }
OAOperation >> tags: anObject [
	tags := anObject
]
