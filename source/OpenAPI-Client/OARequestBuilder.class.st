Class {
	#name : 'OARequestBuilder',
	#superclass : 'Object',
	#instVars : [
		'client',
		'path',
		'queryParameters',
		'pathParameters',
		'baseUri'
	],
	#category : 'OpenAPI-Client',
	#package : 'OpenAPI-Client'
}

{ #category : 'building' }
OARequestBuilder >> addFormBody: aDictionary [
	client entity: (ZnApplicationFormUrlEncodedEntity withAll: (self flattenFormParameters: aDictionary))
]

{ #category : 'as yet unclassified' }
OARequestBuilder >> addJSONBody: aDictionary [ 
	client 
		entity: (ZnEntity 
			with: (NeoJSONWriter toString: aDictionary)
			type: ZnMimeType applicationJson setCharSetUTF8)
]

{ #category : 'building' }
OARequestBuilder >> addCookieParameter: key value: value [
	"Multiple cookie parameters must accumulate into a single 'Cookie' header
	(name=value pairs joined by '; '), rather than each overwriting the last."
	| pair existing |
	pair := key asString , '=' , value asString.
	existing := client request headers at: 'Cookie' ifAbsent: [ nil ].
	client headerAt: 'Cookie' put: (existing
		ifNil: [ pair ]
		ifNotNil: [ existing , '; ' , pair ])
]

{ #category : 'building' }
OARequestBuilder >> addHeaderParameter: key value: value [
	client headerAt: key put: value asString
]

{ #category : 'as yet unclassified' }
OARequestBuilder >> addPathParameter: key value: value [
	pathParameters at: key put: value
]

{ #category : 'accessing' }
OARequestBuilder >> addQueryParameter: key value: value [ 
	queryParameters at: key put: value
]

{ #category : 'accessing' }
OARequestBuilder >> baseUri [
	^ baseUri
]

{ #category : 'accessing' }
OARequestBuilder >> baseUri: uri [
	baseUri := uri
]

{ #category : 'building' }
OARequestBuilder >> buildClient [
	| builtSegements uri |
	builtSegements := ($/ split: path) allButFirst collect: [ :segment |
		(segment beginsWith: '{')
			ifTrue: [ pathParameters at: segment allButFirst allButLast ]
			ifFalse: [ segment ] ] .
	uri := (self baseUri copy addPathSegments: builtSegements).
	uri queryAddAll: queryParameters.
	client url: uri.
	^ client
]

{ #category : 'accessing' }
OARequestBuilder >> client: aClient [ 
	client := aClient
]

{ #category : 'forms' }
OARequestBuilder >> flattenFormParameters: aDictionary [
	| result |
	result := Dictionary new.
	self flattenFormParameters: aDictionary prefix: nil into: result.
	^ result
]

{ #category : 'forms' }
OARequestBuilder >> flattenFormParameters: anObject prefix: aPrefixString into: aDictionary [
	anObject isString ifTrue: [ 
		aDictionary at: aPrefixString put: anObject.
		^ self ].
	((anObject isKindOf: Dictionary) or: [ anObject isKindOf: OrderedDictionary ]) ifTrue: [ 
		anObject keysAndValuesDo: [ :k :v |
			self 
				flattenFormParameters: v 
				prefix: (aPrefixString 
					ifNil: [ k asString ] 
					ifNotNil: [ aPrefixString , (String with: $[) , k asString , (String with: $]) ])
				into: aDictionary ].
		^ self ].
	(anObject isKindOf: SequenceableCollection) ifTrue: [ 
		anObject doWithIndex: [ :v :i |
			self 
				flattenFormParameters: v 
				prefix: (aPrefixString , (String with: $[) , (i - 1) asString , (String with: $]))
				into: aDictionary ].
		^ self ].
	aDictionary at: aPrefixString put: anObject asString
]

{ #category : 'initialization' }
OARequestBuilder >> initialize [ 
	super initialize.
	pathParameters := Dictionary new.
	queryParameters := Dictionary new
]

{ #category : 'as yet unclassified' }
OARequestBuilder >> method: aString [ 
	client method: aString asSymbol 
]

{ #category : 'accessing' }
OARequestBuilder >> path: aString [ 
	path := aString
]
