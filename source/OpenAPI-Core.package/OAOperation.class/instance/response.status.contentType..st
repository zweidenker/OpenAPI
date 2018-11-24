as yet unclassified
response: anObject status: statusCode contentType: contentType
	^ (ZnResponse statusCode: statusCode) 
		entity: ((responses at: statusCode) response: anObject contentType: contentType);
		yourself
