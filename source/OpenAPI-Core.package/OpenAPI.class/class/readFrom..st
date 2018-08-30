instance creation
readFrom: stream
	^ ((NeoJSONReader on: stream)
		nextAs: self)
			prepare