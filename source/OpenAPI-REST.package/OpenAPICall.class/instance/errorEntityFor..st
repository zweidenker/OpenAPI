private
errorEntityFor: anError
	^ ZnEntity 
		with:(NeoJSONWriter toStringPretty: anError)
		type: ZnMimeType applicationJson setCharSetUTF8