as yet unclassified
read: string object: object
	| dict |
	dict := NeoJSONReader fromString: string.
	properties keysAndValuesDo: [ :name :schema |
		object 
			instVarNamed: name
			put: (schema readString: (dict at: name) ) ].
	^ object