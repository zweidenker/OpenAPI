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

{ #category : 'running' }
OpenAPIRestTests >> setUp [
	"Pet instances accumulates in a class-side IdentitySet with no cleanup - across
	repeated test runs within the same image this grows without bound. Reset it
	before each test so tests stay isolated from each other."
	super setUp.
	Pet resetInstances
]
