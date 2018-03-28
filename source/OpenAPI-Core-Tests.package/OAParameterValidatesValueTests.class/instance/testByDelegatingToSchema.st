tests
testByDelegatingToSchema
	| schema sud |
	schema := Mock named: #schema.
	sud := OAParameter new
		schema: schema;
		yourself.
	(sud validate: #value) should strictly satisfy: [ schema validate: #value. ].