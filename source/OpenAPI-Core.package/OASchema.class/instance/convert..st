converstion
convert: value
	"If a format is specified convert the value. Otherwise leave it untouched"
	^ format 
		ifNotNil: [ format readType: value ]
		ifNil: [ value ]