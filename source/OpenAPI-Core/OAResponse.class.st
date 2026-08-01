Class {
	#name : 'OAResponse',
	#superclass : 'OABasicObject',
	#instVars : [
		'description',
		'headers',
		'content',
		'links',
		'operation'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
OAResponse class >> neoJsonMapping: mapper [
	mapper
		for: self
		do: [ :mapping | 
			mapping mapInstVars: #(description).
			(mapping mapInstVar: #headers) valueSchema: #HeaderDictionary.
			(mapping mapAccessor: #content) valueSchema: #ContentDictionary.
			(mapping mapInstVar: #links) valueSchema: #LinkDictionary. ].
	mapper
		for: #HeaderDictionary customDo: [ :mapping | mapping mapWithValueSchema: OAHeader. ];
		for: #ContentDictionary customDo: [ :mapping | mapping mapWithValueSchema: OAMediaTypeObject. ];
		for: #LinkDictionary customDo: [ :mapping | mapping mapWithValueSchema: OALink. ].
]

{ #category : 'visting' }
OAResponse >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitResponse: self
]

{ #category : 'as yet unclassified' }
OAResponse >> api [
	^ operation api
]

{ #category : 'accessing' }
OAResponse >> content [
	^ content
]

{ #category : 'accessing' }
OAResponse >> content: aDictionary [
	aDictionary ifNotNil: [  
		aDictionary values do: [ :each | each response: self ].
		content := aDictionary ]
]

{ #category : 'as yet unclassified' }
OAResponse >> contentAtType: aZnMimeType [ 
	^ content at: aZnMimeType asString
]

{ #category : 'accessing' }
OAResponse >> contentAtType: aString put: aMediaTypeObject [ 
	content at: aString put: aMediaTypeObject 
]

{ #category : 'accessing' }
OAResponse >> description [
	^ description.
]

{ #category : 'as yet unclassified' }
OAResponse >> handleResponse: aResponse [ 
	| contentType |
	(content isNil or: [ content isEmpty ]) ifTrue: [ 
		^ aResponse contents ].
	contentType := aResponse contentType clearCharSet.
	content 
		at: contentType asString
		ifPresent: [:mediaObject |
			^ mediaObject 
				handleResponse: aResponse contents  ]
		ifAbsent: [ 
			OAUnspecifiedError new
				response: aResponse;
				messageText: 'cannot find object for media ', contentType asString ]
]

{ #category : 'accessing' }
OAResponse >> headers [
	^ headers
]

{ #category : 'accessing' }
OAResponse >> headers: anObject [
	headers := anObject
]

{ #category : 'initialization' }
OAResponse >> initialize [ 
	super initialize.
	content := Dictionary new
]

{ #category : 'as yet unclassified' }
OAResponse >> operation [
	^ operation
]

{ #category : 'as yet unclassified' }
OAResponse >> operation: aOperation [ 
	operation := aOperation 
]

{ #category : 'as yet unclassified' }
OAResponse >> response: anObject contentType: contentType [
	^ ZnEntity 
		with: ((content at: contentType) write: anObject)
		type: contentType asZnMimeType 
]
