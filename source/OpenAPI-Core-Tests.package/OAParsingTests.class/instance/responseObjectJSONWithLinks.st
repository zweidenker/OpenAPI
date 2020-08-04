as yet unclassified
responseObjectJSONWithLinks
	^ '
{
"description": "Response with links",
"content": {
 	"application/json": {
   		"schema": {
                  "type": "object",
                  "required": [
                    "_embedded"
                  ],
                  "properties": {
                    "_embedded": {
                      "type": "array",
                      "items": {
                        "$ref": "#/components/schemas/Booking"
                      }
                    }
                  }
                }
          	}
         },
"links": {
              "getActionsForBooking": {
                "$ref": "#/components/links/getActionsForBooking"
              }
            }
}
          
'.