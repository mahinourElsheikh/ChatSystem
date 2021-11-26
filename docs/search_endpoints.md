# Search Endpoint

## Search a message

```
GET /api/v1/applications/:application_id/chats/:chat_id/messages/search HTTP/1.1
Host: localhost:3000
Content-Type: application/json
Cookie: last_seen_locale=en
Content-Length: 18

{
    "q": "Hey"
}
```
### Expected result 
```
{
    "message": [
        {
            "_index": "messages",
            "_type": "message",
            "_score": 2.5532584,
            "_source": {
                "description": "Hey",
                "seq_num": 4
            }
        },
        {
            "_index": "messages",
            "_type": "message",
            "_score": 1.6587734,
            "_source": {
                "description": "Hey",
                "seq_num": 1
            }
        }
    ]
}
```
