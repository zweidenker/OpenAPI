accessing
parameterInboundRouteId
	<openApiParameter: #( common )>
	^ OAParameter new
		in: #path;
		name: 'petId';
		beString;
		required: true