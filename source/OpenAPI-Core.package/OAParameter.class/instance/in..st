accessing
in: aStringOrSymbol
	in := aStringOrSymbol.
	location := ({(#path -> OAPathParameterLocation).
	(#query -> OAQueryParameterLocation).
	(#header -> OAHeaderParametersLocation).
	(#cookie -> OACookieParameterLocation).} asDictionary at: aStringOrSymbol asSymbol) of: self.

	"Parameters from path are required"
	in = #path
		ifTrue: [ required := true ].