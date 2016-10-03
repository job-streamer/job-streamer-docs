type=page
status=publish
~~~~~~

# 通知サーバの設定

## ednファイル
ednファイルを用いてルールの設定を行います。
ednファイルにはコントロールバスからあるキーが送られた時に動作を定義します。
ednファイルはNotificator起動時の第一引数として設定します。

例 :成功メールのjobを作成する場合

    {
      :send-success-email {:uri "http://localhost:45102/default/job/success-mail/executions?Exchange.CONTENT_TYPE=application/edn"}
    }

この設定では:send-success-emailのキーが送られた時"http\://localhost:45102/default/job/success-mail/executions?Exchange.CONTENT\_TYPE=application/edn"にPOSTリクエストを送るので、"success-mail"というjobが実行されます。

例：成功したときsmtpリクエストを送りメール送信する場合

    {
      :send-success-email {
        :uri "smtp://[smtp-server-ip-address]:25?from=example-from@example.com&to=example-to@example.com&subject=success"
        :message "success"
      }
    }

この設定では:send-success-emailのキーが送られた時smtpサーバーに直接メール送信のリクエストが送られます。

### ednファイルのフォーマット
ednファイルは以下の形で記述してください。

    ｛
      :key1 {:uri     "xxx"
             :to      "yyy"
             :message "zzz"}
      :key2{...}
      ...
      :keyx{...}}

:uri - Apache CamelのRouteBuilder#fromに相当する。キーが送られてきたときの動作を記述する。
       設定できる動作は[http://camel.apache.org/components.html](http://camel.apache.org/components.html)を参照
:to  - Apache CamelのRouteBuilder#toに相当する。
:message - Apache Camelのsetbodyに相当する。

## Handlebars（テンプレート機能）を使う
Handlebarsを使うことでメッセージ等のテンプレートを作成することができます。
例えば、以下のようなhbsファイル(success.hbs)を作成します。

    Hello, your batch is {{exit-status}}!
    end time is {{end-time}}

hbsファイル内では以下のキーが指定できます。

|キー名|説明|
|-----|---|
|job-name|job名|
|start-time|開始時刻|
|end-time|終了時刻|
|batch-status|batch status|
|exit-status|exit status|

ednファイルでは以下のように"message-template" というキーでhbsファイルのファイル名を指定します。

    {
      :send-success-email {
        :uri "smtp://[smtp-server-ip-address]:25?from=example-from@example.com&to=example-to@example.com&subject=success"
        :message-template "success"
      }
    }

:send-success-emailのキーが送られると以下のような本文のメールが送信されます。

    Hello, your batch is COMPLETED!end time is Sat Sep 17 01:09:29 JST 2016

## notificatorの起動
以下のように起動します。

    bin/notificator [edn file] [hbs file dir]

hbsファイルを複数用いる場合は同一ディレクトリ内に置いてください。
hbsファイルを用いない場合第二引数は省略可能です。

