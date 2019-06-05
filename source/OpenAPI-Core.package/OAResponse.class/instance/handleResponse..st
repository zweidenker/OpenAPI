as yet unclassified
handleResponse: aZnResponse 
	| contentType |
	content ifNil: [ ^ aZnResponse contents ].
	contentType := aZnResponse contentType clearCharSet.
	content isEmpty ifTrue: [ 
		 ^ aZnResponse  ].
	content 
		at: contentType asString
		ifPresent: [:mediaObject |
			^ mediaObject 
				handleResponse: aZnResponse contents  ].
	Error signal: 'cannot find object for media ', contentType asString.