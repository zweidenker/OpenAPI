requests
operationWithPath: aString andMethod: method
	"If an API does not provide operationId we can still select an operation 
	by path and HTTP method"
	^ (self openApi operationWithPath: aString) 
		perform: method asSymbol