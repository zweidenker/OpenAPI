reading
extractParameter: aCall
	^ parameter read: (aCall request headers at: parameter name ifAbsent: [ ^ nil ])