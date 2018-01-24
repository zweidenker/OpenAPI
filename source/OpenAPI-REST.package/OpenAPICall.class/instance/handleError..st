private
handleError: anError
	self flag: #todo.
	"Error handling needs to be more elaborate. At the moment must handled errors will be client
	errors but it does not need to be"
	^ ZnResponse 
		badRequest: request 
		entity: (ZnStringEntity text: anError messageText)