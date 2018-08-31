as yet unclassified
openApiJsonString
	^ '{
	"openapi" : "3.0.0",
	"info" : ', self infoObjectJSON ,',
	"paths" : ', self pathsObjectJSON ,',
	"components" : ', self componentsJsonString ,'
}'