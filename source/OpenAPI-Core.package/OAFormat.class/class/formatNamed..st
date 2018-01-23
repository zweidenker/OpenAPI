instance creation
formatNamed: aString 
	^ (self allSubclasses reject: #isAbstract)
		detect: [ :each | each formatName = aString ]