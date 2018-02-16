*jsonschema-core
valueOrReferenceSchema: valueSchema

	self reader: [ :jsonReader | | map |
		 jsonReader nextAs: ((jsonReader peekFirstKey = '$ref')
					ifTrue: [ OAReference ]
					ifFalse: [ valueSchema ] ) ].
	self writer: [ :jsonWriter :map | 
		jsonWriter nextPut: map ]