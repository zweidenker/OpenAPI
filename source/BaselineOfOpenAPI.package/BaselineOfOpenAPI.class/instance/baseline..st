baselines
baseline: spec
	<baseline>
	spec for: #common do: [
		spec 
			package: 'OpenAPI-Core' with: [ spec requires: #('NeoJSON') ];
			package: 'OpenAPI-REST' with: [ spec requires: #('OpenAPI-Core' 'Zinc') ];
			project: 'Zinc' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: '2.8.9';
					loads: #('REST' );
					repository: 'http://mc.stfx.eu/ZincHTTPComponents' ];
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: '17';
					repository: 'http://mc.stfx.eu/Neo' ].
		spec
			group: 'default'
					with: #( 'OpenAPI-Core' 'OpenAPI-REST') ]