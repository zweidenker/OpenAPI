as yet unclassified
read: anObject schema: aSchema 
	| object |
	object := NeoJSONObject new.
	aSchema hasProperties ifTrue: [  
		aSchema properties keysAndValuesDo: [ :key :schema |
			anObject 
				at: key
				ifPresent: [ :val | 
					object at: key put: (schema read: val) ] ] ].
	^ object