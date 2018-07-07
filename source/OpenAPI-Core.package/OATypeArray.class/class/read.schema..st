as yet unclassified
read: aCollection schema: aSchema 
	^ aCollection collect: [ :item | 
		aSchema items realSchema read: item ]