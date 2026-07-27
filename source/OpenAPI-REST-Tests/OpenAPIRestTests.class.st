Class {
	#name : 'OpenAPIRestTests',
	#superclass : 'TestCase',
	#category : 'OpenAPI-REST-Tests',
	#package : 'OpenAPI-REST-Tests'
}

{ #category : 'as yet unclassified' }
OpenAPIRestTests >> debugMode [
	^ true
]

{ #category : 'tests' }
OpenAPIRestTests >> delegate [ 

	^ (ZnRestServerDelegate new
			uriSpace: (OpenAPIUriSpace new
				rootClass: self rootCallClass ))
]

{ #category : 'tests' }
OpenAPIRestTests >> rootCallClass [
	^ OpenAPITestCall
]

{ #category : 'running' }
OpenAPIRestTests >> runCase [
	^ ZnCurrentServer 
		value: self
		during: [ super runCase ]
]
