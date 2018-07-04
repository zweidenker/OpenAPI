baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ ""
			spec
				package: 'JSONSchema-Core' with: [ spec requires: #('NeoJSON'). ];
				package: 'OpenAPI-Core' with: [ spec requires: #('JSONSchema-Core' 'NeoJSON'). ];
				package: 'OpenAPI-Core-Tests' with: [ spec requires: #('OpenAPI-Core' 'Mocketry'). ];
				package: 'OpenAPI-REST' with: [ spec requires: #('OpenAPI-Core' 'Zinc'). ];
				project: 'Zinc'
					with: [ spec
						className: #ConfigurationOfZincHTTPComponents;
						versionString: '2.8.10';
						loads: #('REST');
						repository: 'http://mc.stfx.eu/ZincHTTPComponents'. ];
				project: 'NeoJSON'
					with: [ spec
						className: #ConfigurationOfNeoJSON;
						versionString: '17';
						repository: 'http://mc.stfx.eu/Neo'. ].

			spec baseline: 'Mocketry' with: [ spec repository: 'github://dionisiydk/Mocketry:v4.0.x'. ].

			spec
				group: 'default' with: #('Core' 'Tests');
				group: 'Core' with: #('OpenAPI-Core' 'OpenAPI-REST');
				group: 'Tests' with: #('OpenAPI-Core-Tests'). ].