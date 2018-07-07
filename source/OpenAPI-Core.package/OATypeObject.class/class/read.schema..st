as yet unclassified
read: anObject schema: aSchema 
	| object property |
	object := Dictionary new.
	aSchema hasProperties ifTrue: [  
		aSchema properties keysAndValuesDo: [ :key :schema |
			anObject 
				at: key
				ifPresent: [ :val | 
					object at: key put: (schema read: val) ] ] ].
	^ object