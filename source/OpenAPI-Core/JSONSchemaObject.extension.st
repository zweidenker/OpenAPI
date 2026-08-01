Extension { #name : 'JSONSchemaObject' }

{ #category : '*OpenAPI-Core' }
JSONSchemaObject >> acceptOpenApi: aVisitor [
	"Confirmed reached (2026-08-01, traced): OAVisitor>>visitComponents: visits
	components.schemas' values directly (self visitAll: aComponents schemas), hitting
	this for every top-level named schema. But by the time that runs, those schemas are
	already fully resolved - OAReferenceResolveVisitor>>visitOpenApi: converts and
	resolves them via #processSchema:/JSONSchemaReferenceResolveVisitor earlier in the
	very same pass, before calling super visitOpenApi: (which is what reaches here).
	Recursing into sub-elements here would repeat work already done; returning self
	unchanged is correct given today's call order, not a missing feature."
	^ self
]
