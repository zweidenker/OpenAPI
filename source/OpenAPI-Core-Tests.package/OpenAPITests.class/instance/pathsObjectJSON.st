as yet unclassified
pathsObjectJSON
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