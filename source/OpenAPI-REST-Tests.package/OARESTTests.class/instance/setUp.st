running
setUp
	super setUp.
	server := ZnServer startOn: 1700 + 10 atRandom.
	server delegate: 
		(ZnRestServerDelegate new 
			uriSpace: ( OpenAPIUriSpace new 
				rootClass: OpenAPICall;
				yourself )).
	client := ZnClient new
		url: server localUrl;
		yourself
