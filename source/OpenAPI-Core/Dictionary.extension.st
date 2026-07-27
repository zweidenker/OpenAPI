Extension { #name : 'Dictionary' }

{ #category : '*openapi-core' }
Dictionary >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitDictionary: self
]
