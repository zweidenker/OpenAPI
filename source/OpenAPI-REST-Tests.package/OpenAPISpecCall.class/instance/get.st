public
get
	response := ZnResponse ok: (
		ZnEntity 
			with: PetsAPI new specString 
			type: ZnMimeType applicationJson setCharSetUTF8)