accessing
parameterOptionalPetId
	<openApiParameter: #( common )>
	^ OAParameter new
		name: 'Optional-Pet-Id';
		in: #header;
		beInteger;
		required: false;
		description: 'The internal id of the pet in the pet store'
