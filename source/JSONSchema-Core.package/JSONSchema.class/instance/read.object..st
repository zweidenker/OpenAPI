as yet unclassified
read: dict object: object
	properties keysAndValuesDo: [ :name :schema |
		dict 
			at: name
			ifPresent: [ :value | 
				"object 
					perform: name asMutator 
					with: (schema readString: value)" 
				object 
					instVarNamed: name asSymbol 
					put: (schema readFrom: value) ]
			ifAbsent: [ "do nothing for now. Needs to check if required" ] ].
	^ object