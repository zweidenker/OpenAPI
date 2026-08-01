Class {
	#name : 'OARequestBuilderTest',
	#superclass : 'TestCase',
	#category : 'OpenAPI-Client-Tests-Tests',
	#package : 'OpenAPI-Client-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
OARequestBuilderTest >> testAddCookieParameterAccumulatesIntoCookieHeader [
	| client builder |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	builder addCookieParameter: 'session' value: 'abc'.
	builder addCookieParameter: 'theme' value: 'dark'.
	self assert: (client request headers at: 'Cookie') equals: 'session=abc; theme=dark'
]

{ #category : 'tests' }
OARequestBuilderTest >> testAddFormBodyBuildsFormUrlEncodedEntity [
	| client builder entity |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	builder addFormBody: (Dictionary new at: 'email' put: 'test@example.com'; yourself).
	entity := client request entity.
	self assert: entity contentType sub equals: 'x-www-form-urlencoded'.
	self assert: (entity contents at: 'email') equals: 'test@example.com'
]

{ #category : 'tests' }
OARequestBuilderTest >> testAddHeaderParameterSetsRequestHeader [
	"OAHeaderParametersLocation and OACookieParameterLocation used to have no
	#write:value:to: method at all - writing any header or cookie parameter into a
	real request via OAParameter>>copyFrom:to: crashed with #doesNotUnderstand."
	| client builder |
	client := ZnClient new.
	builder := OARequestBuilder new client: client.
	builder addHeaderParameter: 'X-Api-Key' value: 'secret123'.
	self assert: (client request headers at: 'X-Api-Key') equals: 'secret123'
]

{ #category : 'tests' }
OARequestBuilderTest >> testCookieParameterWrittenViaParameterCopyFromTo [
	| param builder client dict |
	client := ZnClient new.
	param := OAParameter new name: 'session'; in: #cookie; required: true; schema: JSONSchema string; yourself.
	builder := OARequestBuilder new client: client.
	dict := Dictionary new at: 'session' put: 'abc'; yourself.
	param copyFrom: dict to: builder.
	self assert: (client request headers at: 'Cookie') equals: 'session=abc'
]

{ #category : 'tests' }
OARequestBuilderTest >> testFlattenArrayOfObjects [
	| builder result items |
	items := OrderedCollection new
		add: (Dictionary new at: 'price' put: 'price_abc'; at: 'quantity' put: '1'; yourself);
		yourself.
	builder := OARequestBuilder new.
	result := builder flattenFormParameters: (Dictionary new at: 'items' put: items; yourself).
	self assert: (result at: 'items[0][price]') equals: 'price_abc'.
	self assert: (result at: 'items[0][quantity]') equals: '1'
]

{ #category : 'tests' }
OARequestBuilderTest >> testFlattenDeeplyNestedObject [
	| builder result nested |
	nested := Dictionary new
		at: 'end_behavior' put: (Dictionary new at: 'missing_payment_method' put: 'cancel'; yourself);
		yourself.
	builder := OARequestBuilder new.
	result := builder flattenFormParameters: (Dictionary new at: 'trial_settings' put: nested; yourself).
	self assert: (result at: 'trial_settings[end_behavior][missing_payment_method]') equals: 'cancel'
]

{ #category : 'tests' }
OARequestBuilderTest >> testFlattenNestedDictionary [
	| builder result |
	builder := OARequestBuilder new.
	result := builder flattenFormParameters: (Dictionary new
		at: 'metadata' put: (Dictionary new at: 'apptiveid' put: 'acc_42'; yourself);
		yourself).
	self assert: (result at: 'metadata[apptiveid]') equals: 'acc_42'
]

{ #category : 'tests' }
OARequestBuilderTest >> testFlattenNestedOrderedDictionary [
	"NeoJSON-produced objects (NeoJSONObject/OrderedDictionary) must flatten the
	same way as plain Dictionary - this is what schema-validated request bodies
	actually are, not a hand-built Dictionary."
	| builder result neoObject |
	neoObject := NeoJSONObject new.
	neoObject at: 'apptiveid' put: 'acc_42'.
	builder := OARequestBuilder new.
	result := builder flattenFormParameters: (Dictionary new
		at: 'metadata' put: neoObject;
		yourself).
	self assert: (result at: 'metadata[apptiveid]') equals: 'acc_42'
]

{ #category : 'tests' }
OARequestBuilderTest >> testFlattenScalarValues [
	| builder result |
	builder := OARequestBuilder new.
	result := builder flattenFormParameters: (Dictionary new
		at: 'customer' put: 'cus_123';
		at: 'trial_end' put: 'now';
		yourself).
	self assert: (result at: 'customer') equals: 'cus_123'.
	self assert: (result at: 'trial_end') equals: 'now'
]

{ #category : 'tests' }
OARequestBuilderTest >> testHeaderParameterWrittenViaParameterCopyFromTo [
	"End-to-end: a header OAParameter must be writable via the same
	#copyFrom:to: path OAOperation>>applyParameters:builder: actually uses."
	| param builder client dict |
	client := ZnClient new.
	param := OAParameter new name: 'X-Api-Key'; in: #header; required: true; schema: JSONSchema string; yourself.
	builder := OARequestBuilder new client: client.
	dict := Dictionary new at: 'X-Api-Key' put: 'secret123'; yourself.
	param copyFrom: dict to: builder.
	self assert: (client request headers at: 'X-Api-Key') equals: 'secret123'
]
