accessing
buildPaths
	^ ((self class rootCallClass withAllSubclasses reject: #isAbstract) 
		collect: [ :each | each path -> each pathItem ]) asDictionary.