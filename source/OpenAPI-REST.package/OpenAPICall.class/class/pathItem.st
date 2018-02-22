accessing
pathItem
	| item pragmas pragmaByOperation |
	item := OAPathItem new.
	pragmas := Pragma allNamed: #openApiParameter: from: self class to: OpenAPICall class.
	pragmaByOperation := pragmas groupedBy: [ :pragma | pragma arguments first first. ].
	(pragmaByOperation includesKey: 'common')
		ifTrue: [ | commonParameters |
			commonParameters := (pragmaByOperation removeKey: 'common')
				collect: [ :each | each method valueWithReceiver: self arguments: #(). ].
			(item implementedMethodsIn: self)
				do: [ :each | (item operationAt: each) addParameters: commonParameters. ]. ].
	pragmaByOperation
		keysAndValuesDo: [ :operation :operationPragmas | 
			(item operationAt: operation)
				addParameters: (operationPragmas collect: [ :each | each method valueWithReceiver: self arguments: #(). ]). ].
	^ item.