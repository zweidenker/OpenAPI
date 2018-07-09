as yet unclassified
resolvePath: aString 
	| stream section |
	stream := aString readStream.
	self assert: (stream upTo: $/) = '#'.
	section := stream upTo: $/.
	(section = 'components') ifTrue: [ 
		^ components consumePath: stream  ].
	self halt.