as yet unclassified
implementedOperations
	^ self implementedMethods collect: [ :each |
		self operationAt: each ]