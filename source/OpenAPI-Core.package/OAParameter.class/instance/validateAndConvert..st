validating
validateAndConvert: input
	| value |
	schema validate: input.
	value := schema format: input.
	self validateContraints: value.
	^ value
	