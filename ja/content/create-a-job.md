type=page
status=publish
~~~~~~


# ジョブの作成

1.  トップページ(http\://{サーバ機のIPアドレス}:{コンソールの立ち上げポート番号（デフォルトは8080)})にて"new"ボタンを押下

![image](img/new_job_button.png)

2.  ジョブを作成
Ex. Batchlet一つのStepだけを持つ簡単なjobを作成する

![image](img/make-step.png)
![image](img/make-batchlet.png)
![image](img/select-batchlet-ref.png)
![image](img/type-job-name.png)

BatchletやItemReader/ItemWriter/ItemProcessorはコントロールバスにデプロイされているものだけが使用できます。
新しいバッチ部品を使用したい場合は [ジョブ部品のデプロイ](./get-started-developer.html)を参照してください。
