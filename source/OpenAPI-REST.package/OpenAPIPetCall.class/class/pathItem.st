accessing
pathItem
	^ OAPathItem new 
		get: (OAOperation new 
			parameters: {
				OAParameter new
					name: 'petId';
					in: #path;
					schema: (OASchema new
						typeString: 'string') })