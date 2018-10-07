as yet unclassified
writeBody: aDictionary builder: builder 
	schema isAnyObject ifTrue: [ 
		 builder addJSONBody: aDictionary ]