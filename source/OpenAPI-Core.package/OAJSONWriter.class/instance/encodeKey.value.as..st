private
encodeKey: key value: value as: valueSchema
	super
		encodeKey: key asString
		value: value 
		as: ((value isKindOf: JSONSchema) 
			ifTrue: [ value class ]
			ifFalse: [ valueSchema ])