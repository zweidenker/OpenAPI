printing
printOn: stream
	stream
		<< 'path item: ' << (api pathForItem: self) << ', '
		<< 'methods: ' 
		<< ($, join: self implementedMethods)
