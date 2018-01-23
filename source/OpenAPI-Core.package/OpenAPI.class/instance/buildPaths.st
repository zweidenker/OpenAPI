accessing
buildPaths
	^ ((self class rootCallClass allSubclasses reject: #isAbstract) 
		collect: [ :each | each path -> each pathItem ]) asDictionary.