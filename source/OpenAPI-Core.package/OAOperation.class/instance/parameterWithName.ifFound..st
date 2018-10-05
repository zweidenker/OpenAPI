as yet unclassified
parameterWithName: aString ifFound: aBlock
	^ parameters 
		detect: [ :each | each name = aString ]
		ifFound: [ :v | aBlock value: v ]