accessing
buildPathItem
	| item |
	item := self newPathItem.
	item 
		summary: self summary;
		description: self description;
		servers: self servers.
	self implementedMethods do: [ :method |
		(item operationAt: method)
			summary: (self summaryForMethod: method);
			description: (self descriptionForMethod: method);
			parameters: (self parametersForMethod: method);
			requestBody: (self requestBodyForMethod: method );
			responses: (self responsesForMethod: method) ].
	^ item
