accessing
requestBody
	<openApiRequestBody: #( post )>
	^ OARequestBody new 
			contentAt: 'application/json' put: (
				OAMediaTypeObject new
					schema: { 
							#name -> (JSONSchema string).
							#age -> (JSONSchema integer) } asJSONSchema )