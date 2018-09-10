tests
testReadIntegerTypeTooBig
	"disbaled as integer is not always restricted"
	"self 
		should: [ JSONTypeInteger read: (2 raisedTo: 33) ]
		raise: JSONTypeErrror 
"