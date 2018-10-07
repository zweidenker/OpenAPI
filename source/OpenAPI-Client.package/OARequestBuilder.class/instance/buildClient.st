building
buildClient
	| builtSegements uri |
	builtSegements := ($/ split: path) allButFirst collect: [ :segment |
		(segment beginsWith: '{')
			ifTrue: [ pathParameters at: segment allButFirst allButLast ]
			ifFalse: [ segment ] ] .
	uri := (self baseUri copy addPathSegments: builtSegements).
	uri queryAddAll: queryParameters.
	client url: uri.
	^ client