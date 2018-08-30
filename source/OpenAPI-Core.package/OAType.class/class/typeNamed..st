instance creation
typeNamed: aString 
	^ (self allSubclasses reject: #isAbstract)
		detect: [ :each | each typeName = aString ]
		ifFound: [ :typeClass | typeClass typeInstance ]
		ifNone: [ Error signal: 'type with name ', aString asString, ' not found' ]