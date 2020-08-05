accessing
instances
	^ instances ifNil: [ 
		instances := IdentitySet new ]