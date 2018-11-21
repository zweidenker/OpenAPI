public
post
	self initializeParameters.
	Pet instances add: valueDelegate.
	response := ZnResponse created: '/pets/', valueDelegate id asString