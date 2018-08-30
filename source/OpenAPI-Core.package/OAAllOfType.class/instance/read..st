as yet unclassified
read: jsonObject
		| object |
	object := NeoJSONObject new.
	schemas do: [ :schema |
		self readProperties: schema properties
		from: jsonObject 
		writeTo: object  ].
	^ object