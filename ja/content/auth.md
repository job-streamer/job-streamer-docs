type=page
status=publish
~~~~~~

# 認証認可

## 認証
JobStreamer を利用するために認証（ログイン）情報が必要です。
ログインしていない状態で Console のいずれかの URL を開くとログイン画面に遷移します。
http://localhost:3000/login

ログイン画面からデフォルトの下記ユーザのID/Passwordを使ってログインしてください。

* ID : admin
* Password : password123

ログアウトする場合はヘッダー右のメニューから「Logout」を選択して下さい。

## 認可
ログインユーザにはジョブに対して三つの権限が存在します。

* admin : 全ての操作が可能
* operator : ジョブの情報参照、実行は可能だがジョブの編集は不可
* watcher : ジョブの情報参照のみ可能

ジョブの実行、編集にはそれぞれ下記の操作が含まれます。

* ジョブの編集
    * ジョブ定義の変更
    * ジョブ設定の変更
    * ジョブの削除
* ジョブの実行
    * ジョブの実行・停止・再開・破棄
    * ジョブスケジュールの変更

Console 上で権限のない操作を行った場合にはエラーメッセージが表示されて実行されません。
デフォルトで存在する "admin" というユーザには "admin" 権限が付与されています。
それ以外の権限を持つユーザを作成する場合は以下の「ユーザ管理」を参照してください。

## ユーザ管理
現状、ログインユーザ作成・削除機能をAPIのみで提供してます。
下記のサンプルを基に実行してください。

```sh
# "operator" 権限を持った、"test-user" というログインユーザを "password123" というパスワードで作成
curl -XPOST localhost:45102/user -H 'Content-Type: application/edn' -d '{:user/id "test-user" :user/password "password123" :roll "operator"}'
# "test-user" という ID のログインユーザを削除
curl -XDELETE localhost:45102/user/test-user
```

### API 実行時の認証
Control-bus の API を利用するためにも認証処理が必要となります。
まず下記の通りログイン API を実行して認証トークンを取得します。

```sh
# username : ログインユーザID
# password : ログインユーザパスワード
curl -XPOST localhost:45102/auth -H "Content-Type: application/edn" -d '{:user/id "admin" :user/password "password123"}' -v
{:token "5f080f9c-3023-4a6a-89fb-de983f768c4d"}
```

この場合、 5f080f9c-3023-4a6a-89fb-de983f768c4d が認証トークンです。
次にこのトークンを使って、"Authorization: Token 5f080f9c-3023-4a6a-89fb-de983f768c4d" ヘッダを付与してリクエストすると、認証ユーザが権限を持つ任意の API を実行することが出来ます。

```sh
curl -XGET -H 'Content-Type: application/edn' -H 'Authorization: Token 5f080f9c-3023-4a6a-89fb-de983f768c4d' http://localhost:45102/default/jobs
{:results [...]}
```

## OAuth2.0認証

JobStreamerでは認証方式として上記の仕組みの他にOAuth2.0を利用できます。
OAuth2.0による認証ではユーザはoperatorの権限を持ったguestユーザとしてログインされます。

### 利用方法

OAuth2.0を利用するためにはcontrol-busのクラスパス上に設定ファイルが必要になります

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
