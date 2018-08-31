accessing
requestBody
	<openApiRequestBody: #( post )>
	^ OARequestBody new 
			contentAt: 'application/json' put: (
				OAMediaTypeObject new
					schema: (OASchema new
						typeString: 'object';
						properties: { 
							#name -> (OASchema string).
							#age -> (OASchema integer) } asDictionary ))