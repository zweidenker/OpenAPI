accessing
parametersSortedByName
	parameters ifNil: [ ^ nil ].
	^ parameters sorted: [ :a :b | a name < b name ]