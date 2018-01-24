validating
validateAndConvert: value
	schema validate: value.
	^ (schema convert: value)
	