visiting
visitReference: aReference
	^ self visit: (resolver resolveReference: aReference) 