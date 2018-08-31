as yet unclassified
read: jsonObject 
	| object |
	object := NeoJSONObject new.
	self 
		readProperties: schema properties
		from: jsonObject
		writeTo: object.  
	^ object