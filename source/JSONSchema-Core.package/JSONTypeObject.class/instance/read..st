as yet unclassified
read: jsonObject 
	| object |
	object := NeoJSONObject new.
	self 
		readProperties: properties
		from: jsonObject
		writeTo: object.  
	^ object