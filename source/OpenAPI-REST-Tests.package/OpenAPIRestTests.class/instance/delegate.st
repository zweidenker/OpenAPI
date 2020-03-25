tests
delegate 

	^ (ZnRestServerDelegate new
			uriSpace: (OpenAPIUriSpace new
				rootClass: self rootCallClass ))