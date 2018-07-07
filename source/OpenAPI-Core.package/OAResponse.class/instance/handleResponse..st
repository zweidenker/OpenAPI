as yet unclassified
handleResponse: aZnResponse 
	^ (content at: aZnResponse contentType asString) handleResponse: aZnResponse contents