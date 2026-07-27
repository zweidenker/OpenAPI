Class {
	#name : 'OAParameterValidatesValueTests',
	#superclass : 'TestCase',
	#category : 'OpenAPI-Core-Tests-Validation',
	#package : 'OpenAPI-Core-Tests',
	#tag : 'Validation'
}

{ #category : 'tests' }
OAParameterValidatesValueTests >> testByDelegatingToSchema [
	| sud |
	sud := OAParameter new
		schema: JSONSchema integer;
		yourself.
	self shouldnt: [ sud validate: 5 ] raise: Error.
	self should: [ sud validate: 'notAnInteger' ] raise: JSONSchemaError
]
