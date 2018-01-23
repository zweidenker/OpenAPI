instance creation
typeNamed: aString 
	^ (self allSubclasses reject: #isAbstract)
		detect: [ :each | each typeName = aString ]