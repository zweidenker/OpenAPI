as yet unclassified
parameterWithName: aString 
	^ parameters detect: [ :each | each name = aString ]