Extension { #name : 'JSONSchemaDefinition' }

{ #category : '*OpenAPI-Core' }
JSONSchemaDefinition >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitSchemaDefinition: self 
]
