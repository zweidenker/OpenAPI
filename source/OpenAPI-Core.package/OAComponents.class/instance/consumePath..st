as yet unclassified
consumePath: aStream 
	| type |
	type := aStream upTo: $/.
	(type = 'schemas') ifTrue: [ 
		^ schemas at: aStream upToEnd ].
	self halt.