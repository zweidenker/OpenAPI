testing
match: request
	| callPath requestPath |
	requestPath := $/ split: request uri path.
	callPath := $/ split: self path allButFirst.
	requestPath with: callPath do: [ :requestPathSegment : callPathSegment |
		(callPathSegment first = ${)
			ifFalse: [ 
				(callPathSegment  = requestPathSegment )
					ifFalse: [ ^ nil ] ] ].
	^ true
	