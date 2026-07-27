Extension { #name : 'JSONSchemaArray' }

{ #category : '*OpenAPI-Core' }
JSONSchemaArray >> acceptOpenApi: aVisitor [ 
	self flag: #todo.
	"should be recurse into sub elements later"
	^ self
]
