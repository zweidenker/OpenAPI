Class {
	#name : 'OAParameterLocation',
	#superclass : 'Object',
	#instVars : [
		'parameter'
	],
	#category : 'OpenAPI-Core-Model',
	#package : 'OpenAPI-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
OAParameterLocation class >> of: anOAParameter [
	^ self new
		parameter: anOAParameter;
		yourself.
]

{ #category : 'as yet unclassified' }
OAParameterLocation >> extractParameter: aCall [
	self shouldBeImplemented.
]

{ #category : 'accessing' }
OAParameterLocation >> parameter: anOAParameter [
	parameter := anOAParameter.
]

{ #category : 'accessing' }
OAParameterLocation >> parameterName [
	^ parameter name.
]

{ #category : 'accessing' }
OAParameterLocation >> parameterSchema [
	^ parameter schema.
]

{ #category : 'value serialization' }
OAParameterLocation >> arrayPairsFor: value name: key style: aStyleString explode: explode [
	"Returns an OrderedCollection of one key->value Association. The value is a single
	String for every style/explode combination except form+explode:true, where it stays
	a collection of strings so the caller can add it as a repeated query parameter
	(one key=value pair per element) instead of joining it into one value."
	| strings |
	strings := value collect: [ :each | self stringifyScalar: each ].
	aStyleString = 'matrix' ifTrue: [
		^ OrderedCollection with: key -> (explode
			ifTrue: [ strings inject: '' into: [ :acc :s | acc , ';' , key , '=' , s ] ]
			ifFalse: [ ';' , key , '=' , (',' join: strings) ]) ].
	aStyleString = 'label' ifTrue: [
		^ OrderedCollection with: key -> ('.' , (explode
			ifTrue: [ '.' join: strings ]
			ifFalse: [ ',' join: strings ])) ].
	aStyleString = 'spaceDelimited' ifTrue: [
		^ OrderedCollection with: key -> (' ' join: strings) ].
	aStyleString = 'pipeDelimited' ifTrue: [
		^ OrderedCollection with: key -> ('|' join: strings) ].
	aStyleString = 'simple' ifTrue: [
		^ OrderedCollection with: key -> (',' join: strings) ].
	"form (query/cookie)"
	^ OrderedCollection with: key -> (explode
		ifTrue: [ strings ]
		ifFalse: [ ',' join: strings ])
]

{ #category : 'value serialization' }
OAParameterLocation >> explodeFor: aStyleString [
	"Per spec, explode defaults to true only for style:form; every other style
	(simple/label/matrix/spaceDelimited/pipeDelimited) defaults to false. deepObject is
	only ever meaningfully defined with explode:true, so it is treated as always-exploded
	regardless of what was actually set."
	aStyleString = 'deepObject' ifTrue: [ ^ true ].
	parameter explode ifNotNil: [ ^ parameter explode ].
	^ aStyleString = 'form'
]

{ #category : 'value serialization' }
OAParameterLocation >> isArrayValue: value [
	^ (value isKindOf: SequenceableCollection) and: [ value isString not and: [ value isSymbol not ] ]
]

{ #category : 'value serialization' }
OAParameterLocation >> isObjectValue: value [
	^ (value isKindOf: Dictionary) or: [ value isKindOf: OrderedDictionary ]
]

{ #category : 'value serialization' }
OAParameterLocation >> objectPairsFor: value name: key style: aStyleString explode: explode [
	"Returns an OrderedCollection of key->value String Associations - exactly one for
	simple/label/matrix and form+explode:false, but one PER PROPERTY for deepObject and
	form+explode:true (the object is flattened into separate top-level parameters)."
	| propertyKeys flatPairs |
	propertyKeys := value keys asOrderedCollection.
	aStyleString = 'deepObject' ifTrue: [
		^ propertyKeys collect: [ :k | (key , '[' , k asString , ']') -> (self stringifyScalar: (value at: k)) ] ].
	aStyleString = 'form' ifTrue: [
		explode ifTrue: [
			^ propertyKeys collect: [ :k | k asString -> (self stringifyScalar: (value at: k)) ] ].
		flatPairs := propertyKeys inject: OrderedCollection new into: [ :acc :k |
			acc add: k asString; add: (self stringifyScalar: (value at: k)); yourself ].
		^ OrderedCollection with: key -> (',' join: flatPairs) ].
	"simple/label/matrix"
	explode ifTrue: [
		| kvPairs |
		kvPairs := propertyKeys collect: [ :k | k asString , '=' , (self stringifyScalar: (value at: k)) ].
		aStyleString = 'matrix' ifTrue: [
			^ OrderedCollection with: key -> (kvPairs inject: '' into: [ :acc :p | acc , ';' , p ]) ].
		aStyleString = 'label' ifTrue: [
			^ OrderedCollection with: key -> ('.' , ('.' join: kvPairs)) ].
		^ OrderedCollection with: key -> (',' join: kvPairs) ].
	flatPairs := propertyKeys inject: OrderedCollection new into: [ :acc :k |
		acc add: k asString; add: (self stringifyScalar: (value at: k)); yourself ].
	aStyleString = 'matrix' ifTrue: [
		^ OrderedCollection with: key -> (';' , key , '=' , (',' join: flatPairs)) ].
	aStyleString = 'label' ifTrue: [
		^ OrderedCollection with: key -> ('.' , (',' join: flatPairs)) ].
	^ OrderedCollection with: key -> (',' join: flatPairs)
]

{ #category : 'value serialization' }
OAParameterLocation >> primitivePairFor: value name: key style: aStyleString [
	| str |
	str := self stringifyScalar: value.
	aStyleString = 'matrix' ifTrue: [ ^ OrderedCollection with: key -> (';' , key , '=' , str) ].
	aStyleString = 'label' ifTrue: [ ^ OrderedCollection with: key -> ('.' , str) ].
	^ OrderedCollection with: key -> str
]

{ #category : 'value serialization' }
OAParameterLocation >> serializePairsFor: value name: key defaultStyle: aDefaultStyleString [
	"Serializes value per OAI 3.0 style/explode rules (falling back to aDefaultStyleString /
	the style-appropriate explode default when the parameter did not set its own). Returns
	an OrderedCollection of key->value Associations - usually exactly one, except for
	deepObject and form+explode:true objects, which flatten into one pair per property."
	| styleName explode |
	styleName := parameter style ifNil: [ aDefaultStyleString ].
	explode := self explodeFor: styleName.
	(self isObjectValue: value) ifTrue: [
		^ self objectPairsFor: value name: key style: styleName explode: explode ].
	(self isArrayValue: value) ifTrue: [
		^ self arrayPairsFor: value name: key style: styleName explode: explode ].
	^ self primitivePairFor: value name: key style: styleName
]

{ #category : 'value serialization' }
OAParameterLocation >> stringifyScalar: value [
	^ value asString
]
