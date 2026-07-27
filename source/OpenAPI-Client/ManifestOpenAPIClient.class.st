"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestOpenAPIClient',
	#superclass : 'PackageManifest',
	#category : 'OpenAPI-Client-Manifest',
	#package : 'OpenAPI-Client',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestOpenAPIClient class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#OpenApiClient #operationWithPath:andMethod: #false)) #'2019-06-21T11:58:19.505087+02:00') )
]
