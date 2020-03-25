running
runCase
	^ ZnCurrentServer 
		value: self
		during: [ super runCase ]