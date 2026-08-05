Extension { #name : 'PetsAPI' }

{ #category : '*OpenAPI-REST-Tests' }
PetsAPI classSide >> rootCallClass [
	"OpenAPIBasePetCall, not the literal OpenAPICall - the latter is the base of every
	OpenAPICall subclass in the whole image, not just PetsAPI's own call hierarchy,
	which made buildPaths (via #withAllSubclasses) pull in unrelated call classes too.
	Lives as an OpenAPI-REST-Tests extension (not in PetsAPI's own OpenAPI-Core-Tests
	home package) since OpenAPIBasePetCall is only defined there."
	^ OpenAPIBasePetCall
]
