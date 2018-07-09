as yet unclassified
convert: aString contentType: aMimeType 
	| methodName |
	methodName := 'convert', aMimeType main capitalized, aMimeType sub capitalized.
	^ self 
		perform: methodName asSymbol asMutator 
		with: aString