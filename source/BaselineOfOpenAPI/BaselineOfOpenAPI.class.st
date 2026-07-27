Class {
	#name : 'BaselineOfOpenAPI',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfOpenAPI',
	#package : 'BaselineOfOpenAPI'
}

{ #category : 'baselines' }
BaselineOfOpenAPI >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec
				package: 'OpenAPI-Core' with: [ spec requires: #('JSONSchema Core' 'NeoJSON'). ];
				package: 'OpenAPI-Core-Tests' with: [ spec requires: #('OpenAPI-Core' 'JSONSchema Tests'). ];
				package: 'OpenAPI-REST' with: [ spec requires: #('OpenAPI-Core' 'ZincHTTPComponents') ];
				package: 'OpenAPI-REST-Tests' with: [ spec requires: #('OpenAPI-REST') ];
				package: 'OpenAPI-Client' with: [ spec requires: #('OpenAPI-Core') ].

			spec
				group: 'default' with: #('Core' 'REST' 'Client' 'Tests');
				group: 'Core' with: #('OpenAPI-Core');
				group: 'REST' with: #('Core' 'OpenAPI-REST');
				group: 'Client' with: #('Core' 'OpenAPI-Client');
				group: 'Tests' with: #('OpenAPI-Core-Tests' 'OpenAPI-REST-Tests').

			self
				neoJson: spec;
				zinHTTPComponents: spec;
				jsonSchema: spec ]
]

{ #category : 'baselines' }
BaselineOfOpenAPI >> jsonSchema: spec [
	spec
		baseline: 'JSONSchema' with: [
			spec repository: 'github://zweidenker/JSONSchema:master/source' ].
	spec
		project: 'JSONSchema Core' copyFrom: 'JSONSchema' with: [
			spec loads: 'Core'];
		project: 'JSONSchema Tests' copyFrom: 'JSONSchema' with: [
			spec loads: 'Tests']
]

{ #category : 'baselines' }
BaselineOfOpenAPI >> neoJson: spec [
	spec baseline: 'NeoJSON' with: [
		spec repository: 'github://svenvc/NeoJSON:master/repository' ]
]

{ #category : 'baselines' }
BaselineOfOpenAPI >> zinHTTPComponents: spec [
	spec baseline: 'ZincHTTPComponents' with: [
		spec
			loads: #('REST');
			repository: 'github://svenvc/zinc/repository']
]
