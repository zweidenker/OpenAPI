Class {
	#name : 'OAParameterValidatesValueTests',
	#superclass : 'TestCase',
	#category : 'OpenAPI-Core-Tests-Validation',
	#package : 'OpenAPI-Core-Tests',
	#tag : 'Validation'
}

{ #category : 'tests' }
OAParameterValidatesValueTests >> testByDelegatingToSchema [
	| schema sud |
	schema := Mock named: #schema.
	sud := OAParameter new
		schema: schema;
		yourself.
	(sud validate: #value) should strictly satisfy: [ schema validate: #value. ].
]
