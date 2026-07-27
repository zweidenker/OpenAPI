Class {
	#name : 'OAParameter',
	#superclass : 'OABasicObject',
	#instVars : [
		'name',
		'in',
		'description',
		'required',
		'deprecated',
		'allowEmptyValue',
		'style',
		'explode',
		'allowReserved',
		'schema',
		'example',
		'examples',
		'content',
		'accessor',
		'writeUsingAccessors',
		'constraints',
		'location'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
OAParameter class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( name in description required deprecated allowEmptyValue style explode allowReserved schema example examples content ).
		mapping mapAccessor: #in.
		(mapping mapInstVar: #schema) valueSchema: OASchemaDefinition ]
]

{ #category : 'visiting' }
OAParameter >> acceptOpenApi: aVisitor [ 
	^ aVisitor visitParameter: self
]

{ #category : 'accessing' }
OAParameter >> addConstraint: aBlock [
	constraints add: aBlock
]

{ #category : 'adding' }
OAParameter >> addConstraint: aBlock label: aString [
	constraints add: { aBlock . aString }
]

{ #category : 'accessing' }
OAParameter >> allowEmptyValue [
	^ allowEmptyValue
]

{ #category : 'accessing' }
OAParameter >> allowEmptyValue: anObject [
	allowEmptyValue := anObject
]

{ #category : 'accessing' }
OAParameter >> allowReserved [
	^ allowReserved
]

{ #category : 'accessing' }
OAParameter >> allowReserved: anObject [
	allowReserved := anObject
]

{ #category : 'accessing' }
OAParameter >> beBoolean [
	schema := JSONSchema boolean
]

{ #category : 'accessing' }
OAParameter >> beInteger [
	schema := JSONSchema integer
]

{ #category : 'accessing' }
OAParameter >> beString [
	schema := JSONSchema string
]

{ #category : 'accessing' }
OAParameter >> beStringFormattedAs: aString [
	schema := JSONSchema string
		formatString: aString
]

{ #category : 'accessing' }
OAParameter >> content [
	^ content
]

{ #category : 'accessing' }
OAParameter >> content: anObject [
	content := anObject
]

{ #category : 'as yet unclassified' }
OAParameter >> copyFrom: aDictionary to: aBuilder [ 
	(aDictionary includesKey: name)
		ifTrue: [ location write: name value: (aDictionary at: name) to: aBuilder ]
		ifFalse: [ 
			required ifTrue: [ OAMissingRequiredParameter signal: 'parameter ', name asString, ' is required but not present' ] ] 
]

{ #category : 'accessing' }
OAParameter >> deprecated [
	^ deprecated
]

{ #category : 'accessing' }
OAParameter >> description [
	^ description
]

{ #category : 'accessing' }
OAParameter >> description: anObject [
	description := anObject
]

{ #category : 'accessing' }
OAParameter >> example [
	^ example
]

{ #category : 'accessing' }
OAParameter >> example: anObject [
	example := anObject
]

{ #category : 'accessing' }
OAParameter >> examples [
	^ examples
]

{ #category : 'accessing' }
OAParameter >> examples: anObject [
	examples := anObject
]

{ #category : 'accessing' }
OAParameter >> explode [
	^ explode
]

{ #category : 'accessing' }
OAParameter >> explode: anObject [
	explode := anObject
]

{ #category : 'accessing' }
OAParameter >> extractParameter: aCall [
	| value |
	value := [location extractParameter: aCall]  on: JSONSchemaError do: [ :ex |
			OAInvalidFormat signal: ex description
		 ].
	value isNil
		ifTrue: [ required
				ifTrue: [ OAMissingRequiredParameter signal: 'parameter ' , name , ' is required but not present' ]
				ifFalse: [ ^ value ] ].
	self validateContraints: value.
	^ value
]

{ #category : 'accessing' }
OAParameter >> extractPathParameter: aCall [
	| index value |
	($/ split: aCall class path allButFirst) withIndexDo: [ :each :idx |
		(each allButFirst allButLast = name ) ifTrue: [ 
			index := idx ] ].
	value := aCall request uri pathSegments at: index.
	self validate: value.
	^ value
]

{ #category : 'extracting' }
OAParameter >> extractQueryParameter: aCall [
	| value |
	value := aCall request uri queryAt: name ifPresent: [ :val | schema readString: val ].

	"
	required ifTrue: [ 
		OAMissingRequiredParameter signal: 'parameter ', name, ' is required but not present' ].
	"
	"value ifNil: [self halt]."
	^ value.
]

{ #category : 'accessing' }
OAParameter >> in [
	^ in
]

{ #category : 'accessing' }
OAParameter >> in: aStringOrSymbol [
	in := aStringOrSymbol.
	location := ({(#path -> OAPathParameterLocation).
	(#query -> OAQueryParameterLocation).
	(#header -> OAHeaderParametersLocation).
	(#cookie -> OACookieParameterLocation).
	(#body -> OABodyParameterLocation) } asDictionary at: aStringOrSymbol asSymbol) of: self.

	"Parameters from path are required"
	in = #path
		ifTrue: [ required := true ].
]

{ #category : 'initialization' }
OAParameter >> initialize [
	super initialize.
	constraints := Set new.
	deprecated := false.
	allowEmptyValue := false.
	required := false.
	allowReserved := false.
	writeUsingAccessors := false.
]

{ #category : 'as yet unclassified' }
OAParameter >> location [
	^ location
]

{ #category : 'accessing' }
OAParameter >> name [
	^ name
]

{ #category : 'accessing' }
OAParameter >> name: anObject [
	name := anObject
]

{ #category : 'printing' }
OAParameter >> printOn: aStream [
	aStream << 'OAParameter name: ' << name << ', in: ' << in
]

{ #category : 'as yet unclassified' }
OAParameter >> read: aString [ 
	^ schema readString: aString
]

{ #category : 'accessing' }
OAParameter >> required [
	^ required
]

{ #category : 'accessing' }
OAParameter >> required: anObject [
	required := anObject
]

{ #category : 'accessing' }
OAParameter >> schema [
	^ schema
]

{ #category : 'accessing' }
OAParameter >> schema: anObject [
	schema := anObject
]

{ #category : 'asserting' }
OAParameter >> shouldUseAccessors [
	^ writeUsingAccessors
]

{ #category : 'accessing' }
OAParameter >> style [
	^ style
]

{ #category : 'accessing' }
OAParameter >> style: anObject [
	style := anObject
]

{ #category : 'accessing' }
OAParameter >> useAccessors [
	writeUsingAccessors := true
]

{ #category : 'as yet unclassified' }
OAParameter >> validate: anObject [
	schema ifNotNil: [ 
		schema validate: anObject ]
]

{ #category : 'validating' }
OAParameter >> validateContraints: value [
	constraints do: [ :constraint |
		((constraint first value: value) = true) ifFalse: [ 
			OAConstraintsError signal: value asString, 'violates constraint: ', constraint second ] ]
]

{ #category : 'writing' }
OAParameter >> writeParameterValueOn: anObject request: request [
	| value |
	self flag: #todo.
	"needs to be improved for required or not. If not required we don't write the
	value. Needs to be checked if that constraint is ok"
	value := self extractParameter: request. 
	value ifNil: [ ^ self ].
	self shouldUseAccessors 
		ifTrue: [ 
			anObject 
				perform: name asValidSelector asMutator 
				with: value ]
		ifFalse: [ 
			anObject 
				instVarNamed: name asValidSelector 
				put: value ]
]
