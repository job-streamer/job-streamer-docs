type=page
status=publish
~~~~~~

# ジョブ設定

## ジョブの同時起動制御
あるジョブが同時に複数実行されると都合の悪い場合があります。
同時実行をさせないためには、ジョブ詳細画面の Settings タブ、shedule settings パネルの Exclusive execution をオンにしてください。
\# 本設定を有効にするとスケジューリング実行時も多重実行であれば実行されなくなってしまうので注意してください。
\# 前のジョブが終わり次第再度ディスパッチするような機能は未実装です。

## ジョブの監視
同じく Settings タブで監視の設定が可能です。

![image](img/notificator_dojob.png)

### 1. バッチステータス、終了ステータスの値に応じてメールを送信する
Notification パネルより設定してください。
Batch status を監視する場合はプルダウンから条件となるステータスを選択して下さい。
Exit status の場合は条件となるステータスを入力してください。
通知内容 (Notification) には通知サーバに設定した通知項目のキーを入力してください。

### 2. 一定時間以上ジョブが実行されていたらメールを送る
shedule settings パネルより設定してください。
Execution constraints に経過分数を入力し、プルダウンで Alert を選択してください。
通知内容 (Notification) には通知サーバに設定した通知項目のキーを入力してください。

### 3. 一定時間以上ジョブが実行されていたらジョブを停止する
shedule settings パネルより設定してください。
Execution constraints に経過分数を入力し、プルダウンで Stop を選択してください。
対象のジョブは停止可能（ジョブを構成する Batchlet が javax.batch.api.AbstractBatchlet.stop を実装）である必要があります。

## 通知サーバ(Notificator) について
詳細は [通知サーバの設定](./notificator-config.html) を参照してください。