Class {
	#name : 'OARequestBuilderTest',
	#superclass : 'TestCase',
	#category : 'OpenAPI-Client-Tests-Tests',
	#package : 'OpenAPI-Client-Tests',
	#tag : 'Tests'
}

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
