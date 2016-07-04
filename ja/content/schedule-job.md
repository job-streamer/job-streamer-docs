type=page
status=publish
~~~~~~


# ジョブのスケジューリング

## スケジュールで自動実行する

[quartz](http://www.quartz-scheduler.org/documentation/)形式でスケジュールを登録することで、ジョブを自動実行できます。

![image](_images/schedule_quartz.png)

## カレンダーの登録方法

1.トップページから右側メニューのプルダウン選択によりカレンダーに移動

![image](img/goto-calendar.png)

2.newボタン押下

![image](img/goto-calendar-new.png)

3.カレンダーを作成

![image](img/goto-calendar.png)

## カレンダーを設定して休日はジョブの実行を抑止する
quartz形式とともにカレンダーも設定することでカレンダーに休日として登録されている日はジョブの実行を抑止することができます。