as yet unclassified
readFrom: aString 
	| json result |
	json := NeoJSONReader fromString: aString.
	result := type read: json schema: self.
	self halt.