accessing
httpClient
	^ httpClient ifNil: [ 
		httpClient := ZnClient new ]