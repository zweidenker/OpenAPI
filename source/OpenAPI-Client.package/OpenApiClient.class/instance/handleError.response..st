as yet unclassified
handleError: anObject response: aResponse 
	(OAUnspecifiedError new
		contents: anObject;
		response: aResponse)
			signal