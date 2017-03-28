type=page
status=publish
~~~~~~

# Authentification and authorization

## Authentification
Authentification is required when you use JobStreamer.
If you open any URL of Console without authentification, you will be redirected to login page.
http://localhost:3000/login

Login with following default ID and Passwod.

* ID : admin
* Password : password123

If you want to logout, click Logout link in the menu located in the right-hand side of header.

## Authorization
JobStreamer has three authorities to a job for a login user.

* admin : All operations for job are allowed.
* operator : Reference of job information and execution of job are allowed. But editing of job is not allowed.
* watcher : Only reference of job information is allowed.

Reference of job and editing of job include following operations respectively.

* Reference of job
    * Change job definition.
    * Change job configuration.
    * Delete job.
* Editing of job
    * Execute and stop, restart, abandon job.
    * Change job schedule.

If you do an unallowed operation on the Console, an error message will appear and the operation will be canceled.
Default user, "admin" has "admin" authority.
Please refer to following "User management" section, if you want to create other users who have other authority.

## User management
Currently, login user creation and deletion are provided by API.
Please execute it like following example.

```sh
# Create login user named "test-user" with "operator" authority and password "password123"
curl -XPOST localhost:45102/user -H 'Content-Type: application/edn' -d '{:user/id "test-user" :user/password "password123" :roll "operator"}'
# Delete login user whose id is "test-user".
curl -XDELETE localhost:45102/user/test-user
```

### Authentification in API execution
You also need authentification when you use Control-bus REST API.
At first you need to get authentification token by executing login API.

```sh
# username : Login user id
# password : Login user password
curl -XPOST localhost:45102/auth -H "Content-Type: application/edn" -d '{:user/id "admin" :user/password "password123"}' -v
{:token "5f080f9c-3023-4a6a-89fb-de983f768c4d"}
```

In this case, 5f080f9c-3023-4a6a-89fb-de983f768c4d is the authentification token.
Next, request with "Authorization: Token 5f080f9c-3023-4a6a-89fb-de983f768c4d" header and you can execute any APIs you are allowed.

```sh
curl -XGET -H 'Content-Type: application/edn' -H 'Authorization: Token 5f080f9c-3023-4a6a-89fb-de983f768c4d' http://localhost:45102/default/jobs
{:results [...]}
```
