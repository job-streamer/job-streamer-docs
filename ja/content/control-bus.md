type=page
status=publish
~~~~~~


# Control-bus

## Control-busとは？
control-busはAPI呼び出しを制御しています。
すべてのAPI呼び出しはcontrol-busを介して行います。
なので直接console->agentといったAPIアクセスが発生することはありません。

![image](img/scheduling.png)

## Control-busで出来ること

* バッチ部品のデプロイ
* ジョブの登録
* ジョブの削除
* ジョブの変更

* ジョブのスケジューリング
* ジョブのスケジュールの停止
* ジョブのスケジューリングの削除

## GitHub
https://github.com/job-streamer/job-streamer-control-bus