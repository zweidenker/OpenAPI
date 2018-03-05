accessing
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapAccessor: #typeLabel to: #error.
		mapping mapAccessor: #messageText to: #description ].
