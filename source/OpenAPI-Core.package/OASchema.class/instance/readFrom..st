as yet unclassified
readFrom: aString 
	| json |
	json := (NeoJSONReader on: aString readStream)
		mapClass: NeoJSONObject;
		next.
	^ type read: json schema: self.
