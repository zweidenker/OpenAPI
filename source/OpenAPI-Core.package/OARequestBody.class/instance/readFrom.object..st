instance creation
readFrom: aCall object: object
	| mimeType bodyString |
	mimeType := aCall request contentType.
	bodyString := aCall request entity string.
	content keys do: [ :key |
		 (key asZnMimeType matches: mimeType) ifTrue: [
			^ (content at: key) read: bodyString object: object ] ].
	NotFound signal: 'no matching contentType for ', mimeType asString