as yet unclassified
applyBody: body builder: builder 
	self hasBody ifTrue: [  | mediaTypeObject |
		body ifNil: [ Error signal: 'cannot use nil for body' ].
		mediaTypeObject := self mediaTypeObjectFor: 'application/json'.
		mediaTypeObject writeBody: body builder: builder ] 