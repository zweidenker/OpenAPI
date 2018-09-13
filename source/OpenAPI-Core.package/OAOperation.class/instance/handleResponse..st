as yet unclassified
handleResponse: aZnResponse 
	responses ifNil: [ 
		 ^  aZnResponse contents].
	^ responses 
		at: aZnResponse status asString
		ifPresent: [ :response |  response handleResponse: aZnResponse ]
		ifAbsent: [ aZnResponse contents ].
