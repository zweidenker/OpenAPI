accessing
buildPaths
	paths := ((self class rootCallClass allSubclasses reject: #isAbstract) 
		collect: [ :each | each path -> each pathItem ]) asDictionary.