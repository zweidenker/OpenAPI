initialization
initialize
	super initialize.
	constraints := Set new.
	deprecated := false.
	allowEmptyValue := false.
	required := false.
	allowReserved := false.
	writeUsingAccessors := false.