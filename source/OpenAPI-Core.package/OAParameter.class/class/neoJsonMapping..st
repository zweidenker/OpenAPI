instance creation
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #( name in description required deprecated allowEmptyValue style explode allowReserved schema example examples content ).
		mapping mapAccessor: #in.
		(mapping mapInstVar: #schema) valueSchema: #OrSchema ].
	mapper for: #OrSchema customDo: [ :mapping |
		mapping 
			reader: [:reader | | stream firstKey |
				stream := (reader instVarNamed: #readStream) clone.
				stream upTo: $".
				firstKey := stream next: 4.
				reader nextAs: ((firstKey = '$ref')
					ifTrue: [ OAReference ] 
					ifFalse: [ OAParameter ]) ]]