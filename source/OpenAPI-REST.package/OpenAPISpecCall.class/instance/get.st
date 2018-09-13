public
get
	response := ZnResponse ok: (
		ZnEntity 
			with: (String streamContents: [:stream |
				(NeoJSONWriter on: stream)
					newLine: Character lf asString;
					prettyPrint: true;
					nextPut: PetsAPI new ])
			type: ZnMimeType applicationJson setCharSetUTF8)