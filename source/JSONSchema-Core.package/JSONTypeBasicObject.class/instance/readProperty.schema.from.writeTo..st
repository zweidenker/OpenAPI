as yet unclassified
readProperty: key schema:schema from: jsonObject writeTo: object
	jsonObject 
		at: key
		ifPresent: [ :val |
			self flag: #todo.
			"disabling nil values here. Needs to be checked what needs to be done
			with existing key but nil value" 
			val ifNotNil: [ 
				object 
					at: key 
					put: (schema read: val) ] ]