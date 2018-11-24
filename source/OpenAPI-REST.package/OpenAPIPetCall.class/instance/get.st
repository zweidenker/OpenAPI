public
get
	response := (Pet instanceWithId: petId)
		ifNotNil: [:pet | 
			self response: pet status: 200 contentType: 'application/json' ]
		ifNil: [ ZnResponse notFound: '/pets/', petId asString ]