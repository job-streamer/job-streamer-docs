

## 認証

全てのAPIを利用するために認証（ログイン）情報が必要となります。
ログインしていない状態で console のいずれかの URL を開くとログイン画面に遷移します。
http://localhost:3000/login

ログイン画面からデフォルトの下記ユーザのID/Passwordを使ってログインしてください。

ID : admin
Password : password123

ログイン後はこれまでと同様に console での操作を行えるようになります。
ログアウトする場合はヘッダー右のメニューから「Logout」を選択して下さい。

## 認可

ログインユーザにはジョブに対して三つの権限が存在します。

* admin : 全ての操作が可能
* operator : ジョブの実行は可能だがジョブの編集は不可
* watcher : ジョブの実行も編集も不可

ジョブの実行、編集にはそれぞれ下記の操作が含まれます。

* ジョブの編集
    * ジョブ定義の変更
    * ジョブ設定の変更
    * ジョブの削除
* ジョブの実行
    * ジョブの実行・停止・再開・破棄
    * ジョブスケジュールの変更

console 上で権限のない操作を行った場合にはエラーメッセージが表示されて実行されません。
デフォルトで存在する "admin" というユーザには "admin" 権限が付与されています。
それ以外の権限を持つユーザを作成する場合は以下の「ユーザ管理」を参照してください。

## ユーザ管理

現状、ログインユーザ作成・削除機能をAPIのみで提供しております。
下記のサンプルを基に実行してください。

```
# "operator" 権限を持った、"test-user" というログインユーザを "password123" というパスワードで作成
curl -XPOST localhost:45102/user -H 'Content-Type: application/edn' -d '{:user/id "test-user" :user/password "password123" :roll "operator"}'
# "test-user" という ID のログインユーザを削除
curl -XDELETE localhost:45102/user/test-user
```

## API実行時の認証

control-bus の API を利用するためにも認証処理が必要となります。
まず下記の通りログイン API を実行して認証トークンを取得します。

```
# username : ログインユーザID
# password : ログインユーザパスワード
# appname : "default"を指定
# next : ログイン成功時の表示画面のURLを指定
# back : ログイン失敗時の表示画面のURLを指定
curl -XPOST "http://localhost:45102/login?username=admin&password=password123&appname=default&next=http://localhost:3000&back=http://localhost:3000/login"
{:token "5f080f9c-3023-4a6a-89fb-de983f768c4d"}
```

この場合、5f080f9c-3023-4a6a-89fb-de983f768c4dが認証トークンです。
次にこのトークンを使って、"Authorization: Token 5f080f9c-3023-4a6a-89fb-de983f768c4d"ヘッダを付与してリクエストすると、認証ユーザが権限を持つ任意の API を実行することが出来ます。

```
curl -XGET -H 'Content-Type: application/edn' -H 'Authorization: Token 5f080f9c-3023-4a6a-89fb-de983f768c4d' http://localhost:45102/default/jobs
{:results [...]}
```