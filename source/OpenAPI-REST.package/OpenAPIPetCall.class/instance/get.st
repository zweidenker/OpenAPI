public
get
	self initializeParameters.
	response := ZnResponse ok: (ZnStringEntity text: 'ok')