private
encodeKey: key value: value as: valueSchema
	super
		encodeKey: key 
		value: value 
		as: ((value isKindOf: JSONSchema) 
			ifTrue: [ value class ]
			ifFalse: [ valueSchema ])