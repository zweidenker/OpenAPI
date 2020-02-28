baselines
jsonSchema: spec
	spec 
		baseline: 'JSONSchema' with: [ 
			spec repository: 'github://zweidenker/JSONSchema/source' ];
		project: 'JSONSchema Core' copyFrom: 'JSONSchema' with: [
			spec loads: 'Core'];
		project: 'JSONSchema Tests' copyFrom: 'JSONSchema' with: [
			spec loads: 'Tests']