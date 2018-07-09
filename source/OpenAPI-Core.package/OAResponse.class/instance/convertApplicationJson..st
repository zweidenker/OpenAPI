as yet unclassified
convertApplicationJson: aString 
	^ (NeoJSONReader on: aString readStream)
			mapClass: NeoJSONObject;
			next