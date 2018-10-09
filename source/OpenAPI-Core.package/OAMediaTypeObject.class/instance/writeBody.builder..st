as yet unclassified
writeBody: aDictionary builder: builder 
	builder addJSONBody: (schema isAnyObject 
		ifTrue: [ aDictionary ]
		ifFalse: [ schema readObject: aDictionary ])
