as yet unclassified
read: string object: object
	| dict |
	dict := NeoJSONReader fromString: string.
	properties keysAndValuesDo: [ :name :schema |
		dict 
			at: name
			ifPresent: [ :value | 
				object 
					perform: name asMutator 
				with: (schema readString: value) ]
			ifAbsent: [ "do nothing for now. Needs to check if required" ] ].
	^ object