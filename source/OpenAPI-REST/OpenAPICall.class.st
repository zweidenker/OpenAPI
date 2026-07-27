Class {
	#name : 'OpenAPICall',
	#superclass : 'ZnRestCall',
	#instVars : [
		'operation'
	],
	#category : 'OpenAPI-REST',
	#package : 'OpenAPI-REST'
}

{ #category : 'accessing' }
OpenAPICall class >> buildPathItem [
	| item |
	item := self newPathItem.
	item 
		summary: self summary;
		description: self description;
		servers: self servers.
	self implementedMethods do: [ :method |
		(item operationAt: method)
			summary: (self summaryForMethod: method);
			description: (self descriptionForMethod: method);
			parameters: (self parametersForMethod: method);
			requestBody: (self requestBodyForMethod: method );
			responses: (self responsesForMethod: method) ].
	^ item

]

{ #category : 'building' }
OpenAPICall class >> deleteDescription [
	^ nil
]

{ #category : 'building' }
OpenAPICall class >> deleteSummary [
	^ nil
]

{ #category : 'accessing' }
OpenAPICall class >> description [
	^ nil
]

{ #category : 'building' }
OpenAPICall class >> descriptionForMethod: aString [ 
	^ self perform: (aString, #Description) asSymbol
]

{ #category : 'building' }
OpenAPICall class >> getDescription [
	^ nil
]

{ #category : 'building' }
OpenAPICall class >> getSummary [
	^ nil
]

{ #category : 'building' }
OpenAPICall class >> headDescription [
	^ nil
]

{ #category : 'building' }
OpenAPICall class >> headSummary [
	^ nil
]

{ #category : 'as yet unclassified' }
OpenAPICall class >> httpMethods [
	^ #( get put post delete options head patch trace )
]

{ #category : 'as yet unclassified' }
OpenAPICall class >> implementedMethods [
	^ self httpMethods select: [ :method | self includesSelector: method asSymbol ]

]

{ #category : 'testing' }
OpenAPICall class >> isAbstract [
	^ self = OpenAPICall 
]

{ #category : 'testing' }
OpenAPICall class >> match: request [
	| callPath requestPath |
	requestPath := $/ split: request uri path.
	callPath := $/ split: self path allButFirst.
	(requestPath size = callPath size) ifFalse: [ 
		^ false ].
	requestPath with: callPath do: [ :requestPathSegment : callPathSegment |
		(callPathSegment first = ${)
			ifFalse: [ 
				(callPathSegment  = requestPathSegment )
					ifFalse: [ ^ false ] ] ].
	^ true
	
]

{ #category : 'accessing' }
OpenAPICall class >> newPathItem [
	^ OAPathItem new
]

{ #category : 'as yet unclassified' }
OpenAPICall class >> objectsForPragmas: aCollection [
	^ aCollection 
		collect: [:each | each method valueWithReceiver: self arguments: #() ]

]

{ #category : 'as yet unclassified' }
OpenAPICall class >> openApiPragmasNamed: aSymbol [
	^ Pragma 
		allNamed: aSymbol
		from: self class 
		to: OpenAPICall class.
]

{ #category : 'as yet unclassified' }
OpenAPICall class >> operationForMethod: aString [ 
	
	^ self pathItem perform: aString asLowercase asSymbol.
	
]

{ #category : 'building' }
OpenAPICall class >> optionsDescription [
	^ nil
]

{ #category : 'building' }
OpenAPICall class >> optionsSummary [
	^ nil
]

{ #category : 'as yet unclassified' }
OpenAPICall class >> parametersForMethod: aSymbol [
	^ self objectsForPragmas: ( self pragmas: #openApiParameter: includingMethod: aSymbol )
		
]

{ #category : 'building' }
OpenAPICall class >> patchDescription [
	^ nil
]

{ #category : 'building' }
OpenAPICall class >> patchSummary [
	^ nil
]

{ #category : 'accessing' }
OpenAPICall class >> pathItem [
	^ self buildPathItem 

]

{ #category : 'building' }
OpenAPICall class >> postDescription [
	^ nil
]

{ #category : 'building' }
OpenAPICall class >> postSummary [
	^ nil
]

{ #category : 'as yet unclassified' }
OpenAPICall class >> pragmas: pragmaName includingMethod: aSymbol [
	^ (self openApiPragmasNamed: pragmaName) 
		select: [ :each | each arguments first includesAny: { aSymbol . #common } ]
]

{ #category : 'building' }
OpenAPICall class >> putDescription [
	^ nil
]

{ #category : 'building' }
OpenAPICall class >> putSummary [
	^ nil
]

{ #category : 'accessing' }
OpenAPICall class >> requestBody [
	^ OARequestBody new
]

{ #category : 'as yet unclassified' }
OpenAPICall class >> requestBodyForMethod: aSymbol [

	| body pragmas |
	pragmas := (self pragmas: #openApiRequestBody:contentType: includingMethod: aSymbol)
		ifEmpty: [ ^ nil ].
	
	body := self requestBody.
	pragmas do: [ :pragma | | mediaObject |
		mediaObject := pragma method valueWithReceiver: self arguments: #().
		pragma arguments second do: [ :contentType | 
			body
				contentAt: contentType 
				put: mediaObject ] ].
	^ body
]

{ #category : 'as yet unclassified' }
OpenAPICall class >> responsesForMethod: aSymbol [

	| responses pragmas pragmaGroups |
	pragmas := (self pragmas: #openApiResponse:status:contentType: includingMethod: aSymbol)
		ifEmpty: [ ^ nil ].
	pragmaGroups := Dictionary new.
	pragmas do: [ :pragma |
		pragma arguments second do: [ :statusCode |
			(pragmaGroups at: statusCode ifAbsentPut: [ OrderedCollection new ])
				add: pragma ] ].
	responses := Dictionary new.
	pragmaGroups keysAndValuesDo: [ :statusCode :statusPragmas | | statusResponse |
		statusResponse := OAResponse new.
		statusPragmas do: [ :pragma |
			pragma value arguments third do: [ :contentType |
				statusResponse contentAtType: contentType put: (pragma method valueWithReceiver: self arguments: #()) ] ].
		responses at: statusCode put: statusResponse ].

	^ responses
]

{ #category : 'accessing' }
OpenAPICall class >> servers [
	^ nil
]

{ #category : 'accessing' }
OpenAPICall class >> summary [
	^ ''
]

{ #category : 'building' }
OpenAPICall class >> summaryForMethod: aString [ 
	^ self perform: (aString, #Summary) asSymbol
]

{ #category : 'building' }
OpenAPICall class >> traceDescription [
	^ nil
]

{ #category : 'building' }
OpenAPICall class >> traceSummary [
	^ nil
]

{ #category : 'accessing' }
OpenAPICall >> bodyValueDelegate [
	^ self valueDelegate
]

{ #category : 'private' }
OpenAPICall >> errorEntityFor: anError [
	^ ZnEntity 
		with:(NeoJSONWriter toStringPretty: anError)
		type: ZnMimeType applicationJson setCharSetUTF8
]

{ #category : 'private' }
OpenAPICall >> errorResponseFor: anError [
	^ ZnResponse statusLine: ZnStatusLine badRequest
]

{ #category : 'public' }
OpenAPICall >> execute [
	^ (self respondsTo: self method)	
		ifTrue: [ 
			[ 
			self preProcess.
			self perform: self method.
			self postProcess. 
			response]
				on: OAError 
				do: [ :err | self handleError: err ] ] 
		ifFalse: [ self delegate wrongMethod: request ]  
]

{ #category : 'private' }
OpenAPICall >> handleError: anError [

	^ (self errorResponseFor: anError) 
		entity: (self errorEntityFor: anError)
		yourself
]

{ #category : 'initialization' }
OpenAPICall >> initializeParameters [

	self operation 
		initializeValuesOn: self
		fromRequest: self
]

{ #category : 'as yet unclassified' }
OpenAPICall >> jsonResponse: anObject status: statusCode [ 
	^ self 
		response: anObject 
		status: statusCode 
		contentType: 'application/json'
]

{ #category : 'initialization' }
OpenAPICall >> operation [
	^ operation ifNil: [
		operation := self operationForMethod: request method asLowercase ]

]

{ #category : 'initialization' }
OpenAPICall >> operationForMethod: aString [
	^ self class operationForMethod: aString

]

{ #category : 'accessing' }
OpenAPICall >> parameterValueDelegate [
	^ self valueDelegate
]

{ #category : 'as yet unclassified' }
OpenAPICall >> postProcess [
	
]

{ #category : 'as yet unclassified' }
OpenAPICall >> preProcess [
	self initializeParameters 
]

{ #category : 'as yet unclassified' }
OpenAPICall >> response: anObject status: statusCode contentType: contentType [
	^ self operation 
		response: anObject status: statusCode contentType: contentType
	
]

{ #category : 'accessing' }
OpenAPICall >> valueDelegate [
	^ self 
]
