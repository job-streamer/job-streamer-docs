type=page
status=publish
~~~~~~

# 通知サーバの設定

ednファイルを用いてルールの設定を行います。
ednファイルにはコントロールバスからあるキーが送られた時に動作を定義します。
:uriキーに指定されたuriに:messageキーで指定されたメッセージをPOSTリクエストを送付します。

例 :

    { :do-job {:uri "http://localhost:45102/default/job/success-mail/executions?Exchange.CONTENT_TYPE=application/edn"
               :message "{}"}
    }

この設定では":do-job"のキーが送られた時"http\://localhost:45102/default/job/success-mail/executions?Exchange.CONTENT\_TYPE=application/edn"にPOSTリクエストを送るので、"success-mail"が実行されます。
コントロールバスと通知サーバは同じサーバに存在する必要があります。
