reading
read: value object: object
	^ [ schema read: value object: object ]
		on: JSONSchemaError 
		do: [ :error | OAInvalidFormat signal: error messageText ]