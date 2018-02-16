as yet unclassified
implementedMethodsIn: aClass 
	^ self methods select: [ :method |  aClass includesSelector: method asSymbol ]