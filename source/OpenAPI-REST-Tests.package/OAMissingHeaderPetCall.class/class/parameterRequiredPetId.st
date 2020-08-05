accessing
parameterRequiredPetId
	<openApiParameter: #( common )>
	^ OAParameter new
		name: 'Required-Pet-Id';
		in: #header;
		beInteger;
		required: true;
		description: 'The internal id of the pet in the pet store'
