accessing
openApi
	^ openApi ifNil: [ 
		openApi := self buildOpenApi ]