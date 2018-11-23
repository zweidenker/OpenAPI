accessing
parameterPetId
	<openApiParameter: #( common )>
	^ OAParameter new
		name: 'petId';
		in: #path;
		beInteger;
		required: true;
		description: 'The internal id of the pet in the pet store'
