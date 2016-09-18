# API Reference

## About

This API is organized around REST. This API has predictable, resource-oriented URLs, and uses HTTP response codes to indicate API errors. JSON(or nothing in case of 204) is returned by all API responses, including errors.

### Errors

API uses HTTP response codes to indicate the success or failure of an API request. In general, codes 200 and 204 indicate success, codes in the 4xx range indicate an error that failed given the information provided, and 500 code indicates an internal error.

### HTTP status code summary

 - 200 - OK. Everything worked as expected and there is some response.
 - 204 - OK. Everything worked as expected and there is an empty response.
 - 404 - Not Found. The requested path or resource doesn't exist.
 - 500 - Server Error. Something went wrong on API's end. (These are rare.)

## Event

### Create

Creates a new event.

`` POST /api/v1/events ``

Parameters:

 - name (50 characters max)
 - started_at (string with Date)
 - finished_at (string with Date)

Possible responses:

 - 200
 - 422

Response example:

```
{
  id: 1
  name: "test"
  started_at: "2016-09-15T09:00:00.000Z"
  finished_at: "2016-09-15T10:00:00.000Z"
}
```

### Show

Shows an event.

`` GET /api/v1/events/:id ``

Parameters:

 - id

Possible responses:

 - 200
 - 404

Response example:

```
{
  id: 1
  name: "test"
  started_at: "2016-09-15T09:00:00.000Z"
  finished_at: "2016-09-15T10:00:00.000Z"
}
```

### Update

Updates an event.

`` PUT /api/v1/events/:id ``

Parameters:

 - id
 - name (50 characters max)
 - started_at (string with Date)
 - finished_at (string with Date)

Possible responses:

 - 200
 - 404
 - 422

Response example:

```
{
  id: 1
  name: "test"
  started_at: "2016-09-15T09:00:00.000Z"
  finished_at: "2016-09-15T10:00:00.000Z"
}
```

### Destroy

Removes an event.

`` DELETE /api/v1/events/:id ``

Parameters:

 - id

Possible responses:

 - 204
 - 404
 
### Index

Shows a list of events.

`` GET /api/v1/events ``

Possible responses:

 - 200

Response example:

```
[{
  id: 1
  name: "test"
  started_at: "2016-09-15T09:00:00.000Z"
  finished_at: "2016-09-15T10:00:00.000Z"
},
{
  id: 2
  name: "test2"
  started_at: "2016-09-15T09:00:00.000Z"
  finished_at: "2016-09-15T10:00:00.000Z"
}]

```