private
handleError: anError

	^ (self errorResponseFor: anError) 
		entity: (self errorEntityFor: anError)
		yourself