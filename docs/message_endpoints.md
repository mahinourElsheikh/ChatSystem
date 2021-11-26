
# Message CRUD
 > - `seq_num`  is unique per chat   
> - the `application_id` is the application `token` 
 > - the `chat_id` and `message_id` that are added in the url are actually their corresponding `seq_num  ` 
 > - To update a message just change the request to be a `PUT` request 
  
## Create a message

```
POST /api/v1/applications/:application_id/chats/:chat_id/messages/ HTTP/1.1
Host: localhost:3000
Content-Type: application/json
Cookie: last_seen_locale=en
Content-Length: 32

{
    "message": "How are you"
}'
```
### Expected result 
```
{
    "message": {
        "description": "Hello There",
        "seq_num": 2
    }
}
```

---
</br>

## List all messages
```
GET /api/v1/applications/:application_id/chats/:chat_id/messages/ HTTP/1.1
Host: localhost:3000
Cookie: last_seen_locale=en
```
### Expected result 
```
{
    "messages": [
        {
            "description": "How are you?",
            "seq_num": 3
        },
        {
            "description": "Hello There",
            "seq_num": 2
        },
        {
            "description": "Hey",
            "seq_num": 1
        }
    ]
}
```
---
</br>

## Get a specific message

```
GET /api/v1/applications/:application_id/chats/:chat_id/messages/:message_id HTTP/1.1
Host: localhost:3000
Cookie: last_seen_locale=en
```
### Expected result 
```
{
    "description": "How are you?",
    "seq_num": 3
}
```
---