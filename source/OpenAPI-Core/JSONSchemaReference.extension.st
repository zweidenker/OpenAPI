Extension { #name : 'JSONSchemaReference' }

{ #category : '*OpenAPI-Core' }
JSONSchemaReference >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitReference: self
]

{ #category : '*OpenAPI-Core' }
JSONSchemaReference >> resolveIn: aMediaTypeObject [ 
	^ aMediaTypeObject resolvePath: path
]
