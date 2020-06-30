baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ ""
			spec
				package: 'OpenAPI-Core' with: [ spec requires: #('JSONSchema Core' 'NeoJSON'). ];
				package: 'OpenAPI-Core-Tests' with: [ spec requires: #('OpenAPI-Core' 'JSONSchema Tests' 'Mocketry'). ];
				package: 'OpenAPI-REST' with: [ spec requires: #('OpenAPI-Core' 'ZincHTTPComponents') ];
				package: 'OpenAPI-REST-Tests' with: [ spec requires: #('OpenAPI-REST') ];
				package: 'OpenAPI-Client' with: [ spec requires: #('OpenAPI-Core') ];
				baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON:master/repository' ];
					
				baseline: 'ZincHTTPComponents' with: [ 
				spec 
					loads: #('REST');
					repository: 'github://svenvc/zinc/repository'].
			spec 
				baseline: 'JSONSchema' with: [ spec repository: 'github://zweidenker/JSONSchema/source' ];
				project: 'JSONSchema Core' copyFrom: 'JSONSchema' with: [
					spec loads: 'Core'];
				project: 'JSONSchema Tests' copyFrom: 'JSONSchema' with: [
					spec loads: 'Tests'];
				baseline: 'Mocketry' with: [ spec repository: 'github://dionisiydk/Mocketry:v4.0.x'. ].

			spec
				group: 'default' with: #('Core' 'REST' 'Client' 'Tests');
				group: 'Core' with: #('OpenAPI-Core');
				group: 'REST' with: #('Core' 'OpenAPI-REST');
				group: 'Client' with: #('Core' 'OpenAPI-Client');
				group: 'Tests' with: #('OpenAPI-Core-Tests' 'OpenAPI-REST-Tests'). ].