# Application CRUD
> The `application_id` in the url is the application's `token`

</br>

## Create an application
 > To update an application just change the request to be a PUT request 

```
POST /api/v1/applications HTTP/1.1
Host: localhost:3000
Content-Type: application/json
Cookie: last_seen_locale=en
Content-Length: 22

{
    "application": {
        "name": "App1"
    }
}
```
### Expected result 
```
{
    "token": "JF5LF1nbxQ8dmg1U95R7fQ",
    "name": "App1"
}
```
---
</br>

## Get an application

```
GET /api/v1/applications/JF5LF1nbxQ8dmg1U95R7fQ HTTP/1.1
Host: localhost:3000
Cookie: last_seen_locale=en
```
### Expected result 
```
{
    "token": "JF5LF1nbxQ8dmg1U95R7fQ",
    "name": "App1",
    "chats_count": 0
}
```
---
</br>

## List All applications

```
GET /api/v1/applications/ HTTP/1.1
Host: localhost:3000
Content-Type: application/json
Cookie: last_seen_locale=en
Content-Length: 36

{
    "page": 1,
    "per_page": 2
}
```
### Expected result 
```
{
    "applications": [
        {
            "token": "MFab3T8OkzdiCD4EsBxHMA",
            "name": "App0",
            "chats_count": 6
        },
        {
            "token": "JF5LF1nbxQ8dmg1U95R7fQ",
            "name": "App1",
            "chats_count": 2
        }
    ],
    "count": 4,
    "per_page": 2,
    "page": 1
}
```
---
</br>