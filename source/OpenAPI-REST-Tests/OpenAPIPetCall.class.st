Class {
	#name : 'OpenAPIPetCall',
	#superclass : 'OpenAPIBasePetCall',
	#instVars : [
		'petId'
	],
	#category : 'OpenAPI-REST-Tests',
	#package : 'OpenAPI-REST-Tests'
}

{ #category : 'accessing' }
OpenAPIPetCall class >> description [ 
	^ 'If you want to look up some information for pets this is the call to use. '
]

{ #category : 'accessing' }
OpenAPIPetCall class >> getDescription [ 
	^ 'A pet can be acquired by using the id of the pet to request it. The id needs to be in the path'
]

{ #category : 'accessing' }
OpenAPIPetCall class >> getSummary [ 
	^ 'A call to acquire a pet'
]

{ #category : 'accessing' }
OpenAPIPetCall class >> parameterPetId [
	<openApiParameter: #( common )>
	^ OAParameter new
		name: 'petId';
		in: #path;
		beInteger;
		required: true;
		description: 'The internal id of the pet in the pet store'

]

{ #category : 'accessing' }
OpenAPIPetCall class >> path [ 
	^ '/pets/{petId}'
]

{ #category : 'as yet unclassified' }
OpenAPIPetCall class >> responseOk [
	<openApiResponse: #(get) status: #(200) contentType: #('application/json')>
	^ OAMediaTypeObject new
		schema: { 
			#name -> (JSONSchema string).
			#age -> (JSONSchema integer) } asJSONSchema
]

{ #category : 'accessing' }
OpenAPIPetCall class >> summary [ 
	^ 'This call is about to acquire pet information'
]

{ #category : 'public' }
OpenAPIPetCall >> get [
	response := (Pet instanceWithId: petId)
		ifNotNil: [:pet | 
			self response: pet status: 200 contentType: 'application/json' ]
		ifNil: [ ZnResponse notFound: '/pets/', petId asString ]
]
