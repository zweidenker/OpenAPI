as yet unclassified
resolveReference: aJSONSchemaReference 
	(aJSONSchemaReference isLocalPath) ifTrue: [ 
		^ components schemas at: ($/ split: aJSONSchemaReference path) fourth ].
	Error signal: 'only local references are supported'