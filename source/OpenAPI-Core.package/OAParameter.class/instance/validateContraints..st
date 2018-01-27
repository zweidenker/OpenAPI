validating
validateContraints: value
	constraints do: [ :constraint |
		((constraint first value: value) = true) ifFalse: [ 
			OAConstraintsError signal: value asString, 'violates constraint: ', constraint second ] ]