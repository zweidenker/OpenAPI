as yet unclassified
read: string object: object
	| dict |
	dict := NeoJSONReader fromString: string.
	properties keysAndValuesDo: [ :name :schema |
		object 
			perform: name asMutator 
			with: (schema readString: (dict at: name) ) ].
	^ object