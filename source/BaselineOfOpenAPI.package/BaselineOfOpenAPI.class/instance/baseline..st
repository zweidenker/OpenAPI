baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'JSONSchema-Core' with: [ spec requires: #('NeoJSON'). ];
				package: 'OpenAPI-Core' with: [ spec requires: #('JSONSchema-Core' 'NeoJSON'). ];
				package: 'OpenAPI-REST' with: [ spec requires: #('OpenAPI-Core' 'Zinc'). ];
				project: 'Zinc'
					with: [ spec
						className: #ConfigurationOfZincHTTPComponents;
						versionString: '2.8.9';
						loads: #('REST');
						repository: 'http://mc.stfx.eu/ZincHTTPComponents'. ];
				project: 'NeoJSON'
					with: [ spec
						className: #ConfigurationOfNeoJSON;
						versionString: '17';
						repository: 'http://mc.stfx.eu/Neo'. ];
				baseline: 'Mocketry' with: [ spec repository: 'github://dionisiydk/Mocketry:v4.0.x'. ].
			spec group: 'default' with: #('OpenAPI-Core' 'OpenAPI-REST'). ].