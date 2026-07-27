Class {
	#name : 'OARequestBody',
	#superclass : 'Object',
	#instVars : [
		'description',
		'content',
		'required'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
OARequestBody class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( description required ).
		(mapping mapInstVar: #content) valueSchema: #MediaTypeObjects.
		 ].
	mapper for: #MediaTypeObjects customDo: [ :mapping |
		mapping mapWithValueSchema: OAMediaTypeObject ]
]

{ #category : 'visiting' }
OARequestBody >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitRequestBody: self
]

{ #category : 'accessing' }
OARequestBody >> content [
	^ content
]

{ #category : 'accessing' }
OARequestBody >> content: anObject [
	content := anObject
]

{ #category : 'accessing' }
OARequestBody >> contentAt: aString [ 
	content ifNotNil: [ 
		content
			at: aString
			ifPresent: [ :value | ^ value ] ].
	NotFound signal: 'no content for ', aString, 'found'
]

{ #category : 'accessing' }
OARequestBody >> contentAt: aString put: value [
	content ifNil: [ content := Dictionary new ].
	content
		at: aString
		put: value
]

{ #category : 'as yet unclassified' }
OARequestBody >> convert: aString from: aZnMimeType [ 
	( aZnMimeType = ZnMimeType applicationJson ) ifTrue: [ 
		^ NeoJSONReader fromString: aString ].
	Error signal: 'cannot convert mime-type ', aZnMimeType asString
]

{ #category : 'accessing' }
OARequestBody >> description [
	^ description
]

{ #category : 'accessing' }
OARequestBody >> description: anObject [
	description := anObject
]

{ #category : 'initialization' }
OARequestBody >> initialize [
	super initialize.
	required := false
]

{ #category : 'instance creation' }
OARequestBody >> readFrom: aCall object: object [
	| mimeType bodyString |
	mimeType := aCall request contentType.
	bodyString := aCall request entity string.
	content keys do: [ :key |
		 (key asZnMimeType matches: mimeType) ifTrue: [
			^ (content at: key) 
				read: bodyString
				object: object ] ].
	NotFound signal: 'no matching contentType for ', mimeType asString
]

{ #category : 'accessing' }
OARequestBody >> required [
	^ required
]

{ #category : 'accessing' }
OARequestBody >> required: anObject [
	required := anObject
]
