as yet unclassified
readProperties: aDictionary from: jsonObject writeTo: object
	 aDictionary keysAndValuesDo: [ :key :schema |
		self readProperty: key schema: schema from: jsonObject writeTo: object ]