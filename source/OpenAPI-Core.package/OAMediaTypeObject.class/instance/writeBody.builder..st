as yet unclassified
writeBody: aDictionary builder: builder 
	| object |
	schema isAnyObject ifTrue: [ 
		 builder addJSONBody: aDictionary ].
	object := NeoJSONObject new.
	schema properties keysAndValuesDo: [ :key :value |
		(aDictionary includesKey: key)
			ifTrue: [ object perform: key asSymbol asMutator with: (aDictionary at: key) ]
			ifFalse: [ (schema isRequired: key)  ifTrue: [ self halt  ] ] ].
	builder addJSONBody: object