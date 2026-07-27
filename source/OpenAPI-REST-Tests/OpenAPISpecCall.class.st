Class {
	#name : 'OpenAPISpecCall',
	#superclass : 'OpenAPIBasePetCall',
	#category : 'OpenAPI-REST-Tests',
	#package : 'OpenAPI-REST-Tests'
}

{ #category : 'accessing' }
OpenAPISpecCall class >> path [
	^ '/spec'
]

{ #category : 'public' }
OpenAPISpecCall >> get [
	response := ZnResponse ok: (
		ZnEntity 
			with: PetsAPI new specString 
			type: ZnMimeType applicationJson setCharSetUTF8)
]
