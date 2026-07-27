Class {
	#name : 'OAMissingHeaderPetCall',
	#superclass : 'OpenAPITestCall',
	#instVars : [
		'requiredPetId'
	],
	#category : 'OpenAPI-REST-Tests',
	#package : 'OpenAPI-REST-Tests'
}

{ #category : 'accessing' }
OAMissingHeaderPetCall class >> parameterOptionalPetId [
	<openApiParameter: #( common )>
	^ OAParameter new
		name: 'Optional-Pet-Id';
		in: #header;
		beInteger;
		required: false;
		description: 'The internal id of the pet in the pet store'

]

{ #category : 'accessing' }
OAMissingHeaderPetCall class >> parameterRequiredPetId [
	<openApiParameter: #( common )>
	^ OAParameter new
		name: 'Required-Pet-Id';
		in: #header;
		beInteger;
		required: true;
		description: 'The internal id of the pet in the pet store'

]

{ #category : 'accessing' }
OAMissingHeaderPetCall class >> path [ 
	^ '/pets/header-missing'
]

{ #category : 'as yet unclassified' }
OAMissingHeaderPetCall class >> responseOk [
	<openApiResponse: #(get) status: #(200) contentType: #('application/json')>
	^ OAMediaTypeObject new
		schema: { 
			#name -> (JSONSchema string).
			#age -> (JSONSchema integer) } asJSONSchema
]

{ #category : 'public' }
OAMissingHeaderPetCall >> get [
	response := self response: Dictionary new status: 200 contentType: 'application/json'
]
