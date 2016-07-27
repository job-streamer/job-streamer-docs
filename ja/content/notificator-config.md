type=page
status=publish
~~~~~~

# 通知サーバの設定

## ednファイル
ednファイルを用いてルールの設定を行います。
ednファイルにはコントロールバスからあるキーが送られた時に動作を定義します。
ednファイルはNotificator起動時の第一引数として設定します。

例 :

    { :do-job {:uri "http://localhost:45102/default/job/success-mail/executions?Exchange.CONTENT_TYPE=application/edn"}
    }

この設定では":do-job"のキーが送られた時"http\://localhost:45102/default/job/success-mail/executions?Exchange.CONTENT\_TYPE=application/edn"にPOSTリクエストを送るので、"success-mail"が実行されます。

ednファイルは以下の形で記述してください。

    ｛:key1 {:uri     "xxx"
             :to      "yyy"
             :message "zzz"}
      :key2{...}
      ...
      :keyx{...}}

:uri - Apache CamelのRouteBuilder#fromに相当する。キーが送られてきたときの動作を記述する。
       設定できる動作はhttp://camel.apache.org/components.htmlを参照
:to  - Apache CamelのRouteBuilder#toに相当する。
:message - Apache Camelのsetbodyに相当する。


