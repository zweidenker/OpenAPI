Class {
	#name : 'OAParsingTests',
	#superclass : 'OpenAPITests',
	#category : 'OpenAPI-Core-Tests',
	#package : 'OpenAPI-Core-Tests'
}

{ #category : 'as yet unclassified' }
OAParsingTests >> componentsErrorModelString [
	^ '{
  "components": {
    "schemas": {
      "ErrorModel": {
        "type": "object",
        "required": [
          "message",
          "code"
        ],
        "properties": {
          "message": {
            "type": "string"
          },
          "code": {
            "type": "integer",
            "minimum": 100,
            "maximum": 600
          }
        }
      },
      "ExtendedErrorModel": {
        "allOf": [
          {
            "$ref": "#/components/schemas/ErrorModel"
          },
          {
            "type": "object",
            "required": [
              "rootCause"
            ],
            "properties": {
              "rootCause": {
                "type": "string"
              }
            }
          }
        ]
      }
    }
  }
}'
]

{ #category : 'as yet unclassified' }
OAParsingTests >> componentsJsonString [
	^ ' {
  "schemas": {
    "Category": {
      "type": "object",
      "properties": {
        "id": {
          "type": "integer",
          "format": "int64"
        },
        "name": {
          "type": "string"
        }
      }
    },
    "Tag": {
      "type": "object",
      "properties": {
        "id": {
          "type": "integer",
          "format": "int64"
        },
        "name": {
          "type": "string"
        }
      }
    }
  },
  "parameters": {
    "skipParam": {
      "name": "skip",
      "in": "query",
      "description": "number of items to skip",
      "required": true,
      "schema": {
        "type": "integer",
        "format": "int32"
      }
    },
    "limitParam": {
      "name": "limit",
      "in": "query",
      "description": "max records to return",
      "required": true,
      "schema" : {
        "type": "integer",
        "format": "int32"
      }
    }
  },
  "responses": {
    "NotFound": {
      "description": "Entity not found."
    },
    "IllegalInput": {
      "description": "Illegal input for operation."
    },
    "GeneralError": {
      "description": "General Error",
      "content": {
        "application/json": {
          "schema": {
            "$ref": "#/components/schemas/GeneralError"
          }
        }
      }
    }
  },
  "securitySchemes": {
    "api_key": {
      "type": "apiKey",
      "name": "api_key",
      "in": "header"
    },
    "petstore_auth": {
      "type": "oauth2",
      "flows": {
        "implicit": {
          "authorizationUrl": "http://example.org/api/oauth/dialog",
          "scopes": {
            "write:pets": "modify pets in your account",
            "read:pets": "read your pets"
          }
        }
      }
    }
  }
}'
]

{ #category : 'as yet unclassified' }
OAParsingTests >> componentsPetSchemaString [
	^ '{
  "components": {
    "schemas": {
      "Pet": {
        "type": "object",
        "discriminator": {
          "propertyName": "petType"
        },
        "properties": {
          "name": {
            "type": "string"
          },
          "petType": {
            "type": "string"
          }
        },
        "required": [
          "name",
          "petType"
        ]
      },
      "Cat": {
        "description": "A representation of a cat. Note that `Cat` will be used as the discriminator value.",
        "allOf": [
          {
            "$ref": "#/components/schemas/Pet"
          },
          {
            "type": "object",
            "properties": {
              "huntingSkill": {
                "type": "string",
                "description": "The measured skill for hunting",
                "default": "lazy",
                "enum": [
                  "clueless",
                  "lazy",
                  "adventurous",
                  "aggressive"
                ]
              }
            },
            "required": [
              "huntingSkill"
            ]
          }
        ]
      },
      "Dog": {
        "description": "A representation of a dog. Note that `Dog` will be used as the discriminator value.",
        "allOf": [
          {
            "$ref": "#/components/schemas/Pet"
          },
          {
            "type": "object",
            "properties": {
              "packSize": {
                "type": "integer",
                "format": "int32",
                "description": "the size of the pack the dog is from",
                "default": 0,
                "minimum": 0
              }
            },
            "required": [
              "packSize"
            ]
          }
        ]
      }
    }
  }
}'
]

{ #category : 'as yet unclassified' }
OAParsingTests >> infoObjectJSON [
	^ '{
  "title": "Sample Pet Store App",
  "description": "This is a sample server for a pet store.",
  "termsOfService": "http://example.com/terms/",
  "contact": {
    "name": "API Support",
    "url": "http://www.example.com/support",
    "email": "support@example.com"
  },
  "license": {
    "name": "Apache 2.0",
    "url": "https://www.apache.org/licenses/LICENSE-2.0.html"
  },
  "version": "1.0.1"
}'
]

{ #category : 'as yet unclassified' }
OAParsingTests >> openApiJsonString [
	^ '{
	"openapi" : "3.0.0",
	"info" : ', self infoObjectJSON ,',
	"paths" : ', self pathsObjectJSON ,',
	"components" : ', self componentsJsonString ,'
}'
]

{ #category : 'as yet unclassified' }
OAParsingTests >> operationObjectJSON [
	^ '{
  "tags": [
    "pet"
  ],
  "summary": "Updates a pet in the store with form data",
  "operationId": "updatePetWithForm",
  "parameters": [
    {
      "name": "petId",
      "in": "path",
      "description": "ID of pet that needs to be updated",
      "required": true,
      "schema": {
        "type": "string"
      }
    },
	{
      "name": "secondId",
      "in": "query",
      "description": "an ID to have more than one",
      "schema": {
        "type": "string"
      }
    }
  ],
  "requestBody": {
    "content": {
      "application/x-www-form-urlencoded": {
        "schema": {
          "type": "object",
           "properties": {
              "name": { 
                "description": "Updated name of the pet",
                "type": "string"
              },
              "status": {
                "description": "Updated status of the pet",
                "type": "string"
             }
           },
        "required": ["status"] 
        }
      }
    }
  },
  "responses": {
    "200": {
      "description": "Pet updated.",
      "content": {
        "application/json": {},
        "application/xml": {}
      }
    },
    "405": {
      "description": "Invalid input",
      "content": {
        "application/json": {},
        "application/xml": {}
      }
    }
  },
  "security": [
    {
      "petstore_auth": [
        "write:pets",
        "read:pets"
      ]
    }
  ]
}'
]

{ #category : 'as yet unclassified' }
OAParsingTests >> parameterObjectString [
	^ '{
  "name": "token",
  "in": "header",
  "description": "token to be passed as a header",
  "required": true,
  "schema": {
    "type": "array",
    "items": {
      "type": "integer",
      "format": "int64"
    }
  },
  "style": "simple"
}'
]

{ #category : 'as yet unclassified' }
OAParsingTests >> parameterReferenceString [
	^ '{
  "name": "token",
  "in": "header",
  "description": "token to be passed as a header",
  "required": true,
  "schema": {
    "$ref" : "#/foo/bar/baz"
  },
  "style": "simple"
}'
]

{ #category : 'as yet unclassified' }
OAParsingTests >> pathsObjectJSON [
	^ '{
  "/pets": {
    "get": {
      "description": "Returns all pets from the system that the user has access to",
		"requestBody" : {  
			"content": {
    			"application/json": {
      				"schema": {
        				"$ref": "#/components/schemas/User"
      				},
      				"examples": {
          			"user" : {
           	 			"summary": "User Example", 
            				"externalValue": "http://foo.bar/examples/user-example.json"
          			} 
        			}
    			}
			}
		},
      "responses": {
        "200": {          
          "description": "A list of pets.",
          "content": {
            "application/json": {
              "schema": {
                "type": "array",
                "items": {
                  "$ref": "#/components/schemas/pet"
                }
              }
            }
          }
        }
      }
    }
  }
}'
]

{ #category : 'as yet unclassified' }
OAParsingTests >> petStoreApiJsonString [
	^ '{
  "openapi": "3.0.0",
  "info": {
    "version": "1.0.0",
    "title": "Swagger Petstore",
    "license": {
      "name": "MIT"
    }
  },
  "servers": [
    {
      "url": "http://petstore.swagger.io/v1"
    }
  ],
  "paths": {
    "/pets": {
      "get": {
        "summary": "List all pets",
        "operationId": "listPets",
        "tags": [
          "pets"
        ],
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "How many items to return at one time (max 100)",
            "required": false,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "An paged array of pets",
            "headers": {
              "x-next": {
                "description": "A link to the next page of responses",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Pets"
                }
              }
            }
          },
          "default": {
            "description": "unexpected error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        }
      },
      "post": {
        "summary": "Create a pet",
        "operationId": "createPets",
        "tags": [
          "pets"
        ],
		  "requestBody" : {  
		     "content": {
              "application/json": {
                 "schema": {
                    "$ref": "#/components/schemas/Pet"
                 }
              }
           }
        },
        "responses": {
          "201": {
            "description": "Null response"
          },
          "default": {
            "description": "unexpected error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        }
      }
    },
    "/pets/{petId}": {
      "get": {
        "summary": "Info for a specific pet",
        "operationId": "showPetById",
        "tags": [
          "pets"
        ],
        "parameters": [
          {
            "name": "petId",
            "in": "path",
            "required": true,
            "description": "The id of the pet to retrieve",
            "schema": {
              "type": "string"
            }
          },
			{
      			"name": "secondId",
      			"in": "query",
      			"description": "just an ID to have more than one",
      			"schema": {
        		"type": "string"
      		}
    }
        ],
        "responses": {
          "200": {
            "description": "Expected response to a valid request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Pets"
                }
              }
            }
          },
          "default": {
            "description": "unexpected error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Error"
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "Pet": {
        "type" : "object",
        "required": [
          "id",
          "name"
        ],
        "properties": {
          "id": {
            "type": "integer",
            "format": "int64"
          },
          "name": {
            "type": "string"
          },
          "tag": {
            "type": "string"
          }
        }
      },
      "Pets": {
        "type": "array",
        "items": {
          "$ref": "#/components/schemas/Pet"
        }
      },
      "Error": {
        "type" : "object",
        "required": [
          "code",
          "message"
        ],
        "properties": {
          "code": {
            "type": "integer",
            "format": "int32"
          },
          "message": {
            "type": "string"
          }
        }
      }
    }
  }
}'
]

{ #category : 'as yet unclassified' }
OAParsingTests >> requestBodyString [
	^ '{
  "description": "user to add to the system",
  "content": {
    "application/json": {
      "schema": {
        "$ref": "#/components/schemas/User"
      },
      "examples": {
          "user" : {
            "summary": "User Example", 
            "externalValue": "http://foo.bar/examples/user-example.json"
          } 
        }
    },
    "application/xml": {
      "schema": {
        "$ref": "#/components/schemas/User"
      },
      "examples": {
          "user" : {
            "summary": "User example in XML",
            "externalValue": "http://foo.bar/examples/user-example.xml"
          }
        }
    },
    "text/plain": {
      "examples": {
        "user" : {
            "summary": "User example in Plain text",
            "externalValue": "http://foo.bar/examples/user-example.txt" 
        }
      } 
    },
    "*/*": {
      "examples": {
        "user" : {
            "summary": "User example in other format",
            "externalValue": "http://foo.bar/examples/user-example.whatever"
        }
      }
    }
  }
}'
]

{ #category : 'as yet unclassified' }
OAParsingTests >> responseObjectJSON [
	^ '
{
  "description": "A complex object array response",
  "content": {
    "application/json": {
      "schema": {
        "type": "array",
        "items": {
          "$ref": "#/components/schemas/VeryComplexType"
        }
      }
    }
  }
}
'.
]

{ #category : 'as yet unclassified' }
OAParsingTests >> schemaPrimitiveString [
	^ '{
  "type": "string",
  "format": "email"
}'
]

{ #category : 'as yet unclassified' }
OAParsingTests >> schemaSimpleString [
	^ '{
  "type": "object",
  "required": [
    "name"
  ],
  "properties": {
    "name": {
      "type": "string"
    },
    "address": {
      "$ref": "#/components/schemas/Address"
    },
    "age": {
      "type": "integer",
      "format": "int32",
      "minimum": 0
    }
  }
}'
]

{ #category : 'tests' }
OAParsingTests >> testOpenAPISpecHasSortedParameters [
	| api string json parameters |
	api := OpenAPI fromString: self petStoreApiJsonString.
	string := api specString.
	json := NeoJSONObject fromString: string.
	parameters := (json paths at: #'/pets/{petId}') get parameters.
	self assert: parameters size equals: 2.
	self assert: parameters first name equals: #petId.
	self assert: parameters second name equals: #secondId
]

{ #category : 'tests' }
OAParsingTests >> testParsingAndSerializingOpenAPI [
	| api |
	api := OpenAPI fromString: self petStoreApiJsonString.
	self 
		shouldnt: [ api specString ] 
		raise: Error 
]

{ #category : 'tests' }
OAParsingTests >> testParsingInfo [
	| info |
	info := NeoJSONReader fromString: self infoObjectJSON as: OAInfo.
	self assert: info title equals: 'Sample Pet Store App'. 
]

{ #category : 'tests' }
OAParsingTests >> testParsingOpenAPI [
	| api path |
	api := OpenAPI fromString: self petStoreApiJsonString.
	self assert: api info title equals: 'Swagger Petstore'.
	self assert: api openapi equals: '3.0.0'.
	self assert: api paths size = 2.

	path := api paths values first.
	self assert: (path isKindOf: OAPathItem)
]

{ #category : 'tests' }
OAParsingTests >> testParsingOperation [
	| operation responses response405 response200 |
	operation := NeoJSONReader fromString: self operationObjectJSON as: OAOperation.
	self assert: operation summary equals: 'Updates a pet in the store with form data'.


	responses := operation responses.
	self assert: (responses isKindOf: Dictionary).
	self assert: responses size equals: 2.
	self assert: (responses includesKey: '405').
	self assert: (responses includesKey: '200').

	response405 := responses at: '405'.
	self assert: (response405 isKindOf: OAResponse).
	self assert: response405 description equals: 'Invalid input'.
	self assert: (response405 content isKindOf: Dictionary).
	self assert: response405 content size equals: 2.
	self assert: (response405 content includesKey: 'application/json').
	self assert: (response405 content includesKey: 'application/xml').
	response405 content values do: [ :each | self assert: (each isKindOf: OAMediaTypeObject) ].

	response200 := responses at: '200'.
	self assert: (response200 isKindOf: OAResponse).
	self assert: response200 description equals: 'Pet updated.'.
	self assert: (response200 content isKindOf: Dictionary).
	self assert: response200 content size equals: 2.
	self assert: (response200 content includesKey: 'application/json').
	self assert: (response200 content includesKey: 'application/xml').
	response200 content values do: [ :each | self assert: (each isKindOf: OAMediaTypeObject) ].
]

{ #category : 'tests' }
OAParsingTests >> testParsingParameterWithSchemaObject [
	| parameter |
	parameter := NeoJSONReader fromString: self parameterObjectString as: OAParameter.
	self assert: parameter description equals: 'token to be passed as a header'. 
]

{ #category : 'tests' }
OAParsingTests >> testParsingParameterWithSchemaReference [
	| parameter |
	parameter := NeoJSONReader fromString: self parameterReferenceString as: OAParameter.
	self assert: parameter schema class = OASchemaDefinition 
]

{ #category : 'tests' }
OAParsingTests >> testParsingPaths [
	| paths |
	paths := (NeoJSONReader on: self pathsObjectJSON readStream)
		for: #OAPaths customDo: [ :mapping | mapping mapWithValueSchema: OAPathItem ];
		nextAs: #OAPaths.
	self assert: paths notEmpty.
	self assert: paths size equals: 1
]

{ #category : 'tests' }
OAParsingTests >> testParsingPetStore [
	| api |
	api := OpenAPI fromString: self petStoreApiJsonString.
	self assert: api info title equals: 'Swagger Petstore'. 
	self assert: api openapi equals: '3.0.0'.
	self assert: api paths size = 2.

]

{ #category : 'tests' }
OAParsingTests >> testParsingRequestBody [
	| requestBody |
	requestBody := NeoJSONReader fromString: self requestBodyString as: OARequestBody.
	self assert: (requestBody contentAt: 'application/json') schema class equals: OASchemaDefinition. 

]

{ #category : 'tests' }
OAParsingTests >> testParsingResponse [
	| response |
	response := NeoJSONReader fromString: self responseObjectJSON as: OAResponse.

	self assert: (response isKindOf: OAResponse).
	self assert: response description equals: 'A complex object array response'.
	self assert: (response content isKindOf: Dictionary).
	self assert: response content size equals: 1.
	self assert: (response content includesKey: 'application/json').
	response content values do: [ :each | self assert: (each isKindOf: OAMediaTypeObject) ].
]

{ #category : 'tests' }
OAParsingTests >> testParsingSchemaPrimitive [
	| schemaDefinition |
	schemaDefinition := NeoJSONReader fromString: self schemaPrimitiveString as: OASchemaDefinition.
	self assert: schemaDefinition schemaClass equals: JSONSchemaString.
	self assert: schemaDefinition format equals: JSONFormatEmail . 
	
]

{ #category : 'tests' }
OAParsingTests >> testParsingSchemaSimple [
	| schemaDefinition |
	schemaDefinition := NeoJSONReader fromString: self schemaSimpleString as: OASchemaDefinition.
	self assert: schemaDefinition schemaClass equals: JSONSchemaObject 
]
