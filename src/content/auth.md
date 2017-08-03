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

## OAuth2.0認証

JobStreamerでは認証方式として上記の仕組みの他にOAuth2.0を利用できます。
OAuth2.0による認証ではユーザはoperatorの権限を持ったguestユーザとしてログインされます。

### 利用方法

OAuth2.0を利用するためにはcontrol-busのクラスパス上に設定ファイルが必要になります。

> resources/job-streamer-control-bus/config.edn

```edn
{:auth {:console-url "http://xxx.yyy.z.ww:3000"
        :control-bus-url "http://xxx.yyy.z.ww:45102"
        :oauth-providers {"yahoo" {:name "Yahoo"                              ;; 必須。ボタンの表示名
                                   :class-name "yahoo"                        ;; オプション。ボタンのクラス名
                                   :domain "https://auth.login.yahoo.co.jp"   ;; 必須。OAuth2.0 認証サーバのドメイン
                                   :client-id "xxxx"                          ;; 必須。OAuth2.0 のクライアントID
                                   :client-secret "xxxx"                      ;; 必須。OAuth2.0 のクライアントシークレット
                                   :scope "openid"                            ;; オプション。OAuth2.0 のスコープ。
                                   :auth-endpoint "yconnect/v2/authorization" ;; 必須。OAuth2.0 の認証エンドポイント。
                                   :token-endpoint "yconnect/v2/token"}       ;; 必須。OAuth2.0 のトークンエンドポイント。
                          "github" {:name "Github"
                                    :class-name "github"
                                    :domain "https://github.com"
                                    :client-id "xxxx"
                                    :client-secret "xxxx"
                                    :auth-endpoint "login/oauth/authorize"
                                    :token-endpoint "login/oauth/access_token"}}}}
```

また利用するOAuth2.0 認証サーバでの設定が必要になります。

動作確認をしたOAuth2.0 認証サーバを以下に示します。
* Github
* Yahoo! ID連携
