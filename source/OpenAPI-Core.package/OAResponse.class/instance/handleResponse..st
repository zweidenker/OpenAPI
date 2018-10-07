as yet unclassified
handleResponse: aZnResponse 
	| contentType |
	content ifNil: [ ^ aZnResponse contents ].
	contentType := aZnResponse contentType clearCharSet.
	content 
		at: contentType asString
		ifPresent: [:mediaObject |
			^ mediaObject 
				handleResponse: (self 
					convert: aZnResponse contents 
					contentType: contentType) ].
	Error signal: 'cannot find object for media ', contentType asString.