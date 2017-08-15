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
curl -XPOST localhost:45102/user -H 'Content-Type: application/edn' -d '{:user/id "test-user" :user/password "password123" :role "operator"}'
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

## OAuth2.0 Authentication

You can use OAuth2.0 as authentication in JobStreamer.
If you login to JobStreamer by using OAuth2.0, You will get the "operator" role.

### How to use

To Use OAuth2.0, You have to locate a configuration file on your class path.

```edn
;; resources/job-streamer-control-bus/config.edn

{:auth {:console-url "http://xxx.yyy.z.ww:3000"
        :control-bus-url "http://xxx.yyy.z.ww:45102"
        :oauth-providers {"yahoo" {:name "Yahoo"                              ;; Required. Name in button
                                   :class-name "yahoo"                        ;; Option. Class name in button
                                   :domain "https://auth.login.yahoo.co.jp"   ;; Required. Authorization server domain in OAuth2.0
                                   :client-id "xxxx"                          ;; Required. Client id in OAuth2.0
                                   :client-secret "xxxx"                      ;; Required. Client secret in OAuth2.0
                                   :scope "openid"                            ;; Option. Scope in OAuth2.0
                                   :auth-endpoint "yconnect/v2/authorization" ;; Required. Authorization endpoint in OAuth2.0
                                   :token-endpoint "yconnect/v2/token"}       ;; Required. Token endpoint in OAuth2.0
                          "github" {:name "Github"
                                    :class-name "github"
                                    :domain "https://github.com"
                                    :client-id "xxxx"
                                    :client-secret "xxxx"
                                    :auth-endpoint "login/oauth/authorize"
                                    :token-endpoint "login/oauth/access_token"}}}}
```

And you have to configure the OAuth2.0 authorization server.

We confirmed that it works with the following OAuth2.0 services.
* Github
* Yahoo! ID connect
