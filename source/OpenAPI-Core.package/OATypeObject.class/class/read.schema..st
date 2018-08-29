as yet unclassified
read: anObject schema: aSchema 
	| object |
	object := NeoJSONObject new.
	aSchema hasProperties ifTrue: [  
		aSchema properties keysAndValuesDo: [ :key :schema |
			anObject 
				at: key
				ifPresent: [ :val |
					self flag: #todo.
					"disabling nil values here. Needs to be checked what needs to be done
					with existing key but nil value" 
					val ifNotNil: [ object at: key put: (schema read: val) ] ] ] ].
	^ object