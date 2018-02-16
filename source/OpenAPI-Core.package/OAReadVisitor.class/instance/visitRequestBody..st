visiting
visitRequestBody: aRequestBody 
	| mimeType bodyString match |
	mimeType := call request contentType.
	bodyString := call request entity string.
	aRequestBody content keys do: [ :key |
		 (key asZnMimeType matches: mimeType) ifTrue: [
			^ self visit: (aRequestBody content at: key)] ].
	NotFound signal: 'no matching contentType for ', mimeType asString