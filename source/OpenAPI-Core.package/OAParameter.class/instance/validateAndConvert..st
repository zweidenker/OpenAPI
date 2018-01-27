validating
validateAndConvert: input
	| value |
	schema validate: input.
	value := schema convert: input.
	self validateContraints: value.
	^ value
	