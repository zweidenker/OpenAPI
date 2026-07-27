Class {
	#name : 'PetsAPI',
	#superclass : 'OpenAPI',
	#category : 'OpenAPI-Core-Tests',
	#package : 'OpenAPI-Core-Tests'
}

{ #category : 'as yet unclassified' }
PetsAPI class >> rootCallClass [
	^ OpenAPICall 
]

{ #category : 'accessing' }
PetsAPI >> openapi [ 
	^ '3.0.2'
]
