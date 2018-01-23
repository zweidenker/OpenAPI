as yet unclassified
openApiJsonString
	^ '{
	"openapi" : "2.0.0",
	"info" : ', self infoObjectJSON ,',
	"paths" : ', self pathsObjectJSON ,'
}'