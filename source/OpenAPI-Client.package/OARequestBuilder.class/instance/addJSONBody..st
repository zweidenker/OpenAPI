as yet unclassified
addJSONBody: aDictionary 
	client 
		entity: (ZnEntity 
			with: (NeoJSONWriter toString: aDictionary)
			type: ZnMimeType applicationJson setCharSetUTF8)