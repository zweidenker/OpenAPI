*jsonschema-core
valueOrReferenceSchema: valueSchema

	self reader: [ :jsonReader | | map |
		 jsonReader nextAs: ((jsonReader peekFirstKey = '$ref')
					ifTrue: [ JSONSchemaReference ]
					ifFalse: [ valueSchema ] ) ].
	self writer: [ :jsonWriter :map | 
		jsonWriter nextPut: map ]