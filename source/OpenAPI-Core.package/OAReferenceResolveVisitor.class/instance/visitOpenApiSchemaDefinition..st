as yet unclassified
visitOpenApiSchemaDefinition: anOASchemaDefinition 
	^ anOASchemaDefinition isReference 
		ifTrue: [ self visit: anOASchemaDefinition reference ]
		ifFalse: [ self processSchema: anOASchemaDefinition ]