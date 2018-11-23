accessing
pathItem
	| item |
	item := OAPathItem new.
	self implementedMethods do: [ :method |
		(item operationAt: method)
			summary: self summary;
			description: self description;
			parameters: (self parametersForOperation: method);
			requestBody: (self requestBodyForOperation: method ) ].
	^ item
