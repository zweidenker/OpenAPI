as yet unclassified
objectsForPragmas: aCollection
	^ aCollection 
		collect: [:each | each method valueWithReceiver: self arguments: #() ]
