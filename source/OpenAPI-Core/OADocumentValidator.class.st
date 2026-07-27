Class {
	#name : 'OADocumentValidator',
	#superclass : 'Object',
	#category : 'OpenAPI-Core',
	#package : 'OpenAPI-Core'
}

{ #category : 'validating' }
OADocumentValidator class >> isValidDocument: aDocument [
	"Antwortet, ob aDocument ein gültiges OpenAPI-Dokument ist (keine Exception bei der Validierung)."
	^ [ self validateDocument: aDocument. true ] on: Error do: [ :e | false ]
]

{ #category : 'schemas' }
OADocumentValidator class >> schemaForVersion: aVersionString [
	"Baut ein JSONSchema aus dem gebündelten OAI-Meta-Schema für aVersionString. INTERIM: strippt format (siehe #stripFormatsIn:)."
	| root |
	root := NeoJSONReader fromString: (OAMetaSchema schemaJsonForVersion: aVersionString).
	self stripFormatsIn: root.
	^ JSONSchema fromString: (NeoJSONWriter toString: root)
]

{ #category : 'private' }
OADocumentValidator class >> stripFormatsIn: anObject [
	"INTERIM: entfernt alle format-Keys, bis JSONSchema unbekannte Formate toleriert (siehe OpenAPI roadmap + Task task_7b802120). Danach ersatzlos entfernen, damit Format-Annotationen erhalten bleiben."
	anObject isDictionary
		ifTrue: [
			anObject removeKey: 'format' ifAbsent: [ ].
			anObject valuesDo: [ :v | self stripFormatsIn: v ] ]
		ifFalse: [
			(anObject isCollection and: [ anObject isString not ])
				ifTrue: [ anObject do: [ :v | self stripFormatsIn: v ] ] ]
]

{ #category : 'validating' }
OADocumentValidator class >> validateDocument: aDocument [
	"Validiert ein OpenAPI-Dokument, Version automatisch aus dem openapi-Feld erkannt."
	| doc version |
	doc := aDocument isString
		ifTrue: [ NeoJSONReader fromString: aDocument ]
		ifFalse: [ aDocument ].
	version := doc at: 'openapi' ifAbsent: [ self error: 'document has no openapi version field' ].
	^ self validateDocument: doc version: version
]

{ #category : 'validating' }
OADocumentValidator class >> validateDocument: aDocument version: aVersionString [
	"Validiert ein OpenAPI-Dokument (Dictionary oder JSON-String) gegen das gebündelte OAI-Meta-Schema der Version. Wirft JSONSchemaError bei ungültig; liefert das geparste Dokument bei gültig."
	| doc |
	doc := aDocument isString
		ifTrue: [ NeoJSONReader fromString: aDocument ]
		ifFalse: [ aDocument ].
	(self schemaForVersion: aVersionString) validate: doc.
	^ doc
]
