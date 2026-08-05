Class {
	#name : 'OADocumentValidator',
	#superclass : 'Object',
	#classVars : [
		'SchemaCache'
	],
	#category : 'OpenAPI-Core',
	#package : 'OpenAPI-Core'
}

{ #category : 'schemas' }
OADocumentValidator class >> cacheKeyForVersion: aVersionString [
	"Mehrere Patch-Versionen (z.B. 3.0.0, 3.0.3) teilen sich dasselbe Meta-Schema. Auf den major.minor-Bucket normalisieren, damit der Cache nicht pro Patch-Version waechst."
	(aVersionString beginsWith: '3.0') ifTrue: [ ^ '3.0' ].
	^ aVersionString
]

{ #category : 'validating' }
OADocumentValidator class >> isValidDocument: aDocument [
	"Antwortet, ob aDocument ein gültiges OpenAPI-Dokument ist (keine Exception bei der Validierung)."
	^ [ self validateDocument: aDocument. true ] on: Error do: [ :e | false ]
]

{ #category : 'schemas' }
OADocumentValidator class >> resetSchemaCache [
	"Leert den Schema-Cache (z.B. für Tests oder wenn sich gebündelte Meta-Schemas ändern)."
	SchemaCache := nil
]

{ #category : 'schemas' }
OADocumentValidator class >> schemaCache [
	"Lazily initialisierter Cache: normalisierter Versions-Bucket -> gebautes JSONSchema. Vermeidet, das teure OAI-Meta-Schema bei jeder Validierung neu zu parsen/bauen."
	^ SchemaCache ifNil: [ SchemaCache := Dictionary new ]
]

{ #category : 'schemas' }
OADocumentValidator class >> schemaForVersion: aVersionString [
	"Baut (und cached, siehe #schemaCache) ein JSONSchema aus dem gebündelten OAI-Meta-Schema für aVersionString."
	^ self schemaCache
		at: (self cacheKeyForVersion: aVersionString)
		ifAbsentPut: [ JSONSchema fromString: (OAMetaSchema schemaJsonForVersion: aVersionString) ]
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

{ #category : 'validating' }
OADocumentValidator class >> validationErrorFor: aDocument [
	"Wie #isValidDocument:, liefert bei Ungültigkeit aber den tatsächlichen JSONSchemaError statt ihn zu verschlucken (welche Regel wurde verletzt). Antwortet nil, wenn das Dokument gültig ist."
	^ [ self validateDocument: aDocument. nil ]
		on: JSONSchemaError
		do: [ :e | e ]
]

{ #category : 'validating' }
OADocumentValidator class >> validationErrorFor: aDocument version: aVersionString [
	"Wie #validationErrorFor:, aber mit expliziter Version statt Auto-Erkennung aus dem openapi-Feld."
	^ [ self validateDocument: aDocument version: aVersionString. nil ]
		on: JSONSchemaError
		do: [ :e | e ]
]

{ #category : 'validating' }
OADocumentValidator class >> validationErrorMessageFor: aDocument [
	"Bequemlichkeit über #validationErrorFor: - liefert eine lesbare Beschreibung der verletzten Regel (Fehlerklasse + messageText), oder nil, wenn das Dokument gültig ist."
	| error |
	error := self validationErrorFor: aDocument.
	^ error ifNotNil: [ error class name , ': ', error messageText ]
]
