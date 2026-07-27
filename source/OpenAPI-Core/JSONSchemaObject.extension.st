Extension { #name : 'JSONSchemaObject' }

{ #category : '*OpenAPI-Core' }
JSONSchemaObject >> acceptOpenApi: aVisitor [ 
	self flag: #todo.
	"should be recurse into sub elements later"
	^ self
]
