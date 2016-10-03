type=page
status=publish
~~~~~~


# ジョブの作成

1.  トップページ(http\://{サーバ機のIPアドレス}:{コンソールの立ち上げポート番号（デフォルトは8080)})にて"new"ボタンを押下

![image](img/new_job_button.png)

2.  Scratchの要領で、ドラッグ＆ドロップにてジョブを作成

![image](img/new_job.png)


BatchletやItemReader/ItemWriter/ItemProcessorはコントロールバスにデプロイされているものだけが使用できます。
新しいバッチ部品を使用したい場合は [ジョブ部品のデプロイ](./get-started-developer.html)を参照してください。

##プロパティの設定

プロパティを設定する手順は以下の通りです

1. 設定ボタンを押下し、設定を開く
![image](img\open-propety-dialog.png)
2. Propertyを必要な数だけProperties内にドラッグアンドドロップする
![image](img\property-area.png)
3. Propertiesにkey/valueの組を登録する
![image](img\setting-properties.png)