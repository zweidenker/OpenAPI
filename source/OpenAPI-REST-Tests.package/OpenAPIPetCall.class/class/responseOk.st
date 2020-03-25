as yet unclassified
responseOk
	<openApiResponse: #(get) status: #(200) contentType: #('application/json')>
	^ OAMediaTypeObject new
		schema: { 
			#name -> (JSONSchema string).
			#age -> (JSONSchema integer) } asJSONSchema