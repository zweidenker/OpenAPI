baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ ""
			self 
				zinc: spec;
				jsonSchema: spec;
				mocketry: spec;
				neoJson: spec.
				
			spec
				package: 'OpenAPI-Core' with: [ spec requires: #('JSONSchema Core' 'NeoJSON'). ];
				package: 'OpenAPI-Core-Tests' with: [ spec requires: #('OpenAPI-Core' 'JSONSchema Tests' 'Mocketry'). ];
				package: 'OpenAPI-REST' with: [ spec requires: #('OpenAPI-Core' 'ZincHTTPComponents') ];
				package: 'OpenAPI-REST-Tests' with: [ spec requires: #('OpenAPI-REST') ];
				package: 'OpenAPI-Client' with: [ spec requires: #('OpenAPI-Core') ].
				
			spec
				group: 'default' with: #('Core' 'REST' 'Client' 'Tests');
				group: 'Core' with: #('OpenAPI-Core');
				group: 'REST' with: #('Core' 'OpenAPI-REST');
				group: 'Client' with: #('Core' 'OpenAPI-Client');
				group: 'Tests' with: #('OpenAPI-Core-Tests' 'OpenAPI-REST-Tests'). ].
