instance creation
neoJsonMapping: mapper
	super neoJsonMapping: mapper.
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( default ).
		mapping mapAccessor: #typeString mutator: #typeString: to: #type.
		mapping mapAccessor: #formatString mutator: #formatString: to: #format ]