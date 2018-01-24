accessing
in: aStringOrSymbol
	in := aStringOrSymbol.
	"Parameters from path are required"
	(in = #path) ifTrue: [ required := true ]