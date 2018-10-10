as yet unclassified
specString
	^ String streamContents: [ :stream |
		 self specStringOn: stream ]