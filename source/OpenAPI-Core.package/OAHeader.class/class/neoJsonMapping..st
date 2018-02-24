accessing
neoJsonMapping: mapper
	"
The Header Object follows the structure of the Parameter Object with the following changes:

- name MUST NOT be specified, it is given in the corresponding headers map.
- in MUST NOT be specified, it is implicitly in header.
- (???) All traits that are affected by the location MUST be applicable to a location of header (for example, style).
	"

	self flag: #toRefactor.	"Copied from OAParameter class >> neoJsonMapping:. To be refactored to get rid of the duplication."

	mapper
		for: self
		do: [ :mapping | 
			mapping mapInstVars: #(description required deprecated allowEmptyValue style explode allowReserved schema example examples content).
			(mapping mapInstVar: #schema) valueSchema: #SchemaOrReference. ].
	mapper for: #SchemaOrReference customDo: [ :mapping | mapping valueOrReferenceSchema: OASchema. ].