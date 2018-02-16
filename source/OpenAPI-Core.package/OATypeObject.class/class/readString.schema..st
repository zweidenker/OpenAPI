reading
readString: string schema: schema
	| reader input dict |
	dict := Dictionary new.
	reader := NeoJSONReader on: string readStream.
	input := reader next.
	input keysAndValuesDo: [ :key :value | | property |
		property := schema properties 
			detect: [ :each | each key = key ]
			ifNone: [ nil ].
		property ifNotNil: [
			dict at: property key put: (property value readString: value) ] ].
	^ dict