as yet unclassified
handleResponse: aResponse 
	| contentType |
	(content isNil or: [ content isEmpty ]) ifTrue: [ 
		^ aResponse contents ].
	contentType := aResponse contentType clearCharSet.
	content 
		at: contentType asString
		ifPresent: [:mediaObject |
			^ mediaObject 
				handleResponse: aResponse contents  ]
		ifAbsent: [ 
			OAUnspecifiedError new
				response: aResponse;
				messageText: 'cannot find object for media ', contentType asString ]