Class {
	#name : 'OpenApiClient',
	#superclass : 'Object',
	#instVars : [
		'baseUri',
		'openApi',
		'httpClient'
	],
	#category : 'OpenAPI-Client',
	#package : 'OpenAPI-Client'
}

{ #category : 'accessing' }
OpenApiClient >> baseUri [
	^ baseUri
]

{ #category : 'accessing' }
OpenApiClient >> baseUri: anUriOrString [
	baseUri := anUriOrString asZnUrl 
]

{ #category : 'accessing' }
OpenApiClient >> buildOpenApi [
	self subclassResponsibility 
]

{ #category : 'requests' }
OpenApiClient >> call: aString withArguments: aCollection [
	^ self 
		operation: (self openApi operationWithId: aString)
		arguments: aCollection	

]

{ #category : 'as yet unclassified' }
OpenApiClient >> handleError: anObject response: aResponse [ 
	(OAUnspecifiedError new
		contents: anObject;
		response: aResponse)
			signal
]

{ #category : 'accessing' }
OpenApiClient >> httpClient [
	^ httpClient ifNil: [ 
		httpClient := ZnClient new ]
]

{ #category : 'accessing' }
OpenApiClient >> openApi [
	^ openApi ifNil: [ 
		openApi := self buildOpenApi ]
]

{ #category : 'accessing' }
OpenApiClient >> openApi: anObject [
	openApi := anObject
]

{ #category : 'requests' }
OpenApiClient >> operation: operation arguments: aCollection [
	^ self 
		operation: operation 
		arguments: aCollection 
		body: nil
]

{ #category : 'requests' }
OpenApiClient >> operation: operation arguments: aCollection body: anObject [
	^ self 
		operation: operation 
		arguments: aCollection 
		body: anObject 
		beforeSendDo: nil
]

{ #category : 'requests' }
OpenApiClient >> operation: operation arguments: aCollection body: anObject beforeSendDo: aBlock [
	| builder response client responseContent |
	
	builder := OARequestBuilder new 
		baseUri: self baseUri;
		path: operation path;
		client: self httpClient.
		
	operation 
		prepareBuilder: builder;
		applyParameters: aCollection builder: builder;
		applyBody: anObject builder: builder.
		
	client := builder buildClient.
	aBlock ifNotNil: [ aBlock value: client ].
	response := client
		execute;
		response.
	responseContent := operation handleResponse: response.
	^ response isSuccess 
		ifTrue: [  responseContent ]
		ifFalse: [ self handleError: responseContent request: client request response: response ] 
]

{ #category : 'requests' }
OpenApiClient >> operationWithId: aString arguments: aCollection body: anObject [

	^ self 
		operation: (self openApi operationWithId: aString)
		arguments: aCollection 	
		body: anObject
	
]

{ #category : 'requests' }
OpenApiClient >> operationWithPath: aString andMethod: method [
	"If an API does not provide operationId we can still select an operation 
	by path and HTTP method"
	^ (self openApi operationWithPath: aString) 
		perform: method asSymbol
]

{ #category : 'requests' }
OpenApiClient >> operationWithPath: aString method: method arguments: aCollection body: anObject [

	^ self 
		operation: (self operationWithPath: aString andMethod: method)
		arguments: aCollection 	
		body: anObject
	
]

{ #category : 'accessing' }
OpenApiClient >> setBasicAuthenticationUsername: username password: password [ 
	self httpClient setBasicAuthenticationUsername: username password: password 

]
