accessing
parameterPetId
	<openApiParameter: #( common )>
	^ OAParameter new
		in: #path;
		name: 'petId';
		beInteger;
		required: true