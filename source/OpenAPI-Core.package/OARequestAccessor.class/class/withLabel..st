as yet unclassified
withLabel: aString 
	^ (self allSubclasses reject: #isAbstract)
		detect: [ :each | each label = aString ]