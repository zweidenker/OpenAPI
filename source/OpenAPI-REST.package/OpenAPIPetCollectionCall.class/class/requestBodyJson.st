accessing
requestBodyJson
	<openApiRequestBody: #( post ) contentType: #( 'application/json' )>
	^ OAMediaTypeObject new
		schema: { 
			#name -> (JSONSchema string).
			#age -> (JSONSchema integer) } asJSONSchema