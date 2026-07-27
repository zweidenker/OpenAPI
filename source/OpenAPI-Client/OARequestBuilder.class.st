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

{ #category : 'as yet unclassified' }
OARequestBuilder >> addJSONBody: aDictionary [ 
	client 
		entity: (ZnEntity 
			with: (NeoJSONWriter toString: aDictionary)
			type: ZnMimeType applicationJson setCharSetUTF8)
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
