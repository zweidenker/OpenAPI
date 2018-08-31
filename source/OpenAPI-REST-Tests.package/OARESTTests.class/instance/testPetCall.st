tests
testPetCall

	client request url addPathSegments: #( pets #abc ).
	client get.
