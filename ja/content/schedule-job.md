type=page
status=publish
~~~~~~


# ジョブのスケジューリング

## スケジュールで自動実行する

[cron expressions](http://www.quartz-scheduler.org/documentation/quartz-2.x/tutorials/crontrigger.html)形式でスケジュールを登録することで、ジョブを自動実行できます。

![image](img/schedule_quartz.png)

### スケジュールの簡易登録
1. スケジュールのパターン（日次・週次・月次）を選択します。

![image](img/select-pattern-of-schedule.png)

2. 発火時間を入力します。

![image](img/input-fire-time.png)

3. cron expressionsが出力されます。

![image](img/output-cron.png)


## カレンダーの登録方法

1.トップページから右側メニューのプルダウン選択によりカレンダーに移動

![image](img/goto-calendar.png)

2.newボタン押下

![image](img/goto-calendar-new.png)

3.カレンダーを作成

![image](img/create-calendar.png)

## 業務日付に合わせたカレンダーを設定する

夜間バッチなどで、実際の日付とは異なった日付で処理したい場合があります。
（ex. 1/2 01:00を1/1 25:00とみなす)
そういうときは実際の日付での何時からを1日とみなすのかを「Day start」の項目に入力してください。

## カレンダーを設定して休日はジョブの実行を抑止する
cron expressionsとともにカレンダーも設定することでカレンダーに休日として登録されている日はジョブの実行を抑止することができます。
