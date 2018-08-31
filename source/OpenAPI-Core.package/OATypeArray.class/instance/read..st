as yet unclassified
read: aCollection
	^ aCollection collect: [ :item | 
		schema items realSchema read: item ]