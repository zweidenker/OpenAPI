Extension { #name : 'JSONSchemaArray' }

{ #category : '*OpenAPI-Core' }
JSONSchemaArray >> acceptOpenApi: aVisitor [
	"See JSONSchemaObject>>acceptOpenApi: - same confirmed-harmless reasoning applies
	(reached via OAVisitor>>visitComponents:, but only after schemas are already fully
	resolved via #processSchema: earlier in the same pass)."
	^ self
]
