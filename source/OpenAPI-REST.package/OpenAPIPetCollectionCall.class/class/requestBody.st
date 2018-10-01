accessing
requestBody
	<openApiRequestBody: #( post )>
	^ OARequestBody new 
			contentAt: 'application/json' put: (
				OAMediaTypeObject new
					schema: (OASchemaDefinition new
						typeString: 'object';
						properties: { 
							#name -> (JSONSchema string).
							#age -> (JSONSchema integer) } asDictionary ))