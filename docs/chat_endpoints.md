
# Chat CRUD
 > - `seq_num`  is unique per application   
 > - the `chat_id` is  the `seq_num`
 > - the `application_id` is the application `token` 
 > - To update a message just change the request to be a `PUT` request 


## Create a chat
 There is no update for a chat
```
POST /api/v1/applications/:application_id/chats HTTP/1.1
Host: localhost:3000
Content-Type: application/json
Cookie: last_seen_locale=en
Content-Length: 32

{
    "message": "How are you"
}
```
### Expected result 
```
{
    "chats": {
        "seq_num": 1,
        "messages_count": 1
    }
}
```

---
</br>

## List all chats
```
GET /api/v1/applications/:application_id/chats HTTP/1.1
Host: localhost:3000
Cookie: last_seen_locale=en
```
### Expected result 
```
{
    "chats": [
        {
            "seq_num": 2,
            "messages_count": 1,
            "messages": [
                {
                    "description": "Hi",
                    "seq_num": 1
                }
            ]
        },
        {
            "seq_num": 1,
            "messages_count": 1,
            "messages": [
                {
                    "description": "Hey",
                    "seq_num": 1
                }
            ]
        }
    ]
}
```
</br>

## Get a chat specific

```
GET /api/v1/applications/:application_id/chats/:chat_id HTTP/1.1
Host: localhost:3000
Cookie: last_seen_locale=en
```
### Expected result 
```
[
    {
        "seq_num": 1,
        "messages_count": 1,
        "messages": [
            {
                "description": "Hey",
                "seq_num": 1
            }
        ]
    }
]
```