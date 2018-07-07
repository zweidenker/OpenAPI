accessing
paths: anObject
	paths := anObject.
	paths values do: [ :path | path api: self ]