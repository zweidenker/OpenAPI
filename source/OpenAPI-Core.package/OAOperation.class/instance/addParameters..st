as yet unclassified
addParameters: aCollection 
	parameters ifNil: [ parameters := OrderedCollection new ].
	parameters addAll: aCollection