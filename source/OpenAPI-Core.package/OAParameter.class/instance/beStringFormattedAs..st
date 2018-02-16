accessing
beStringFormattedAs: aString
	schema := OASchema new
		typeString: 'string';
		formatString: aString