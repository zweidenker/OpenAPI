as yet unclassified
response: anObject contentType: contentType
	^ ZnEntity 
		with: ((content at: contentType) write: anObject)
		type: contentType asZnMimeType 