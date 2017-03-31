type=page
status=publish
~~~~~~

# ジョブの作成

## 1. job-streamer-console のログイン画面を開く
http://[サーバ機のIPアドレス]:[コンソールの立ち上げポート番号（デフォルト:8080)]

## 2. User name / password を入力してログイン
built-in の管理者ユーザは admin / password123

## 3. トップページにて "New" ボタンを押下

![image](img/new_job_button.png)

## 4. ジョブを作成
Ex. Batchlet一つのStepだけを持つ簡単なjobを作成する

![image](img/make-step.png)
![image](img/make-batchlet.png)
![image](img/select-batchlet-ref.png)
![image](img/type-job-name.png)

* Attribute の設定
![image](img/set-attr.png)
* Property の設定
    * Property の Value には下記の形式 (EL式) でジョブ自体のパラメータを指定することが可能
        \#{jobParameters['パラメータ名']}

![image](img/set-properties.png)

バッチ部品 (Batchlet/ItemReader/ItemWriter/ItemProcessor 等) はコントロールバスにデプロイされているものだけが使用できます。
新しいバッチ部品を使用したい場合は [ジョブ部品のデプロイ](./deploy-batch-components.html) を参照してください。
