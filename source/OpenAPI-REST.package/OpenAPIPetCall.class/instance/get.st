public
get
	response := (Pet instanceWithId: petId)
		ifNotNil: [:pet | 
			ZnResponse ok: (ZnEntity 
				with: (NeoJSONWriter toStringPretty: pet)
				type: ZnMimeType applicationJson setCharSetUTF8) ]
		ifNil: [ ZnResponse notFound: '/pets/', petId asString ]