as yet unclassified
visitDictionary: aDictionary
	 aDictionary ifNil: [ ^  nil ].
	^ aDictionary collect: [ :each | self visit: each ]