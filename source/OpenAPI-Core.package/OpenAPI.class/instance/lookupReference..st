as yet unclassified
lookupReference: aJSONSchemaReference 
	(aJSONSchemaReference isLocalPath) ifTrue: [ 
		Transcript show: aJSONSchemaReference path; cr.
"		(aJSONSchemaReference path = '#/components/schemas/LinkGroupBean') ifTrue: [ 
			self halt ].
"		^ components schemas at: ($/ split: aJSONSchemaReference path) fourth ].
	Error signal: 'only local references are supported'