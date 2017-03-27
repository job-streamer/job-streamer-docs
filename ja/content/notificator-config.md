type=page
status=publish
~~~~~~

# 通知サーバの設定

## 設定ファイル
edn 形式のファイルにより設定をします。
設定ファイルにはコントロールバスからあるキーが送られた時の動作を定義します。
Notificator 起動時の第一引数として当ファイルのパスを渡すことで設定を反映します。（後述）

### 例1: 成功メールの job を作成する場合

    {
      :send-success-email {:uri "http://localhost:45102/default/job/success-mail/executions?Exchange.CONTENT_TYPE=application/edn"}
    }

この設定ではコントロールバスより :send-success-email のキーが送られた時 "http\://localhost:45102/default/job/success-mail/executions?Exchange.CONTENT\_TYPE=application/edn" に POST リクエストを送り、"success-mail" というジョブを実行します。

### 例2: 成功したとき smtp リクエストを送りメール送信する場合

    {
      :send-success-email {
        :uri "smtp://[smtp-server-ip-address]:25?from=example-from@example.com&to=example-to@example.com&subject=success"
        :message "success"
      }
    }

この設定では :send-success-email のキーが送られた時 smtp サーバーに直接メール送信のリクエストを送ります。

### ednファイルのフォーマット
ednファイルは以下の形で記述してください。

    {:key1 {:uri     "xxx"
            :to      "yyy"
            :message "zzz"}
     :key2 {...}
     ...
     :keyx{...}}

* :uri - キーが送られてきたときの動作を記述する
    * Apache CamelのRouteBuilder#from に相当
    * 設定できる動作は[http://camel.apache.org/components.html](http://camel.apache.org/components.html)を参照
* :to  - Apache Camel の RouteBuilder#to に相当
* :message - Apache Camel の setbodyに相当

## Handlebars（テンプレート機能）を使う
Handlebars を使うことでメッセージ等のテンプレートを作成することができます。
例えば、以下のような hbs ファイル(success.hbs)を作成します。

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

ednファイルでは以下のように "message-template" というキーで hbs ファイルのファイル名(拡張子なし)を指定します。

    {
      :send-success-email {
        :uri "smtp://[smtp-server-ip-address]:25?from=example-from@example.com&to=example-to@example.com&subject=success"
        :message-template "success"
      }
    }

:send-success-emailのキーが送られると以下のような本文のメールが送信されます。

    Hello, your batch is COMPLETED!end time is Sat Sep 17 01:09:29 JST 2016

## Notificator の起動
以下のように起動します。

    bin/notificator [edn file] [hbs file dir]

hbs ファイルを複数用いる場合は同一ディレクトリ内に置いてください。
hbs ファイルを用いない場合第二引数は省略可能です。
