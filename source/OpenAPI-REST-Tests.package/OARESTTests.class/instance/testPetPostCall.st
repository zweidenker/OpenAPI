tests
testPetPostCall

	client request url addPathSegments: #( pets ).
	client entity: (ZnEntity 
		with: '{ "name" : "fiffi" , "age" : 8 }'
		type: ZnMimeType applicationJson).
	client post.
