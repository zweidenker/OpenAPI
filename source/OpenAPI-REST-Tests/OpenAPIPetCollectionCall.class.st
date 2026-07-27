Class {
	#name : 'OpenAPIPetCollectionCall',
	#superclass : 'OpenAPIBasePetCall',
	#instVars : [
		'petId',
		'valueDelegate'
	],
	#category : 'OpenAPI-REST-Tests',
	#package : 'OpenAPI-REST-Tests'
}

{ #category : 'accessing' }
OpenAPIPetCollectionCall class >> path [ 
	^ '/pets'
]

{ #category : 'accessing' }
OpenAPIPetCollectionCall class >> requestBody [ 
	^ super requestBody 
		description: 'A pet containing name and age';
		yourself
]

{ #category : 'accessing' }
OpenAPIPetCollectionCall class >> requestBodyJson [
	<openApiRequestBody: #( post ) contentType: #( 'application/json' )>
	^ OAMediaTypeObject new
		schema: { 
			#name -> (JSONSchema string).
			#age -> (JSONSchema integer) } asJSONSchema
]

{ #category : 'public' }
OpenAPIPetCollectionCall >> post [
	self initializeParameters.
	Pet instances add: valueDelegate.
	response := ZnResponse created: '/pets/', valueDelegate id asString
]

{ #category : 'accessing' }
OpenAPIPetCollectionCall >> valueDelegate [
	^ valueDelegate ifNil: [ 
		valueDelegate := Pet new ]
]
