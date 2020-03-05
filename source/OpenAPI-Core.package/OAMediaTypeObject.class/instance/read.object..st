as yet unclassified
read: value object: object
	^ [schema read: value object: object] on: JSONSchemaError do: [ :ex |
			OAInvalidFormat signal: ex description
		 ]