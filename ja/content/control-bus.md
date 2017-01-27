type=page
status=publish
~~~~~~


# Control-bus

## Control-busとは？
control-busはAPI呼び出しを制御しています。
すべてのAPI呼び出しはcontrol-busを介して行います。
なので直接console->agentといったAPIアクセスが発生することはありません。

## Control-busで出来ること

* バッチ部品のデプロイ
* ジョブの登録
* ジョブの削除
* ジョブの変更

* ジョブの実行
* ジョブの停止
* ジョブの再実行

* カレンダーの作成
* カレンダーの削除
* カレンダーの更新

* ジョブのスケジューリング
* ジョブのスケジュールの停止
* ジョブのスケジューリングの削除

## Control-bus APIs
Control-busのAPIはednとJSONに対応しています.

### Create a appliccation

```
POST /apps
```

#### Example

```clojure
{
  :name "batch-example"
  :description "Batch example"
  :classpath [
    "file:///home/app/target/classes"
    "file:///var/m2/repository/xxx/xxx.jar"
    "file:///var/m2/repository/yyy/yyy.jar"
    "file:///var/m2/repository/zzz/zzz.jar"
  ]
}
```

`NOTICE`

> Currently, JobStreamer supports only single application.

### List jobs

```
GET /:app-name/jobs
```

####Query
jobを条件検索したい場合は以下のようにパラメータを付加することでできます。

```
GET /:app-name/jobs?q=[query]
```

queryでは基本的にスペース区切りでjob名を指定することで、部分一致検索を行います。
それ以外にもプレフィックスをつけることで様々な検索が可能です。

|prefix|Description|
|----|-----------|
|exit-status:|最終実行のexit-statusとパラメータが部分一致するかどうか|
|since:|最終実行の終了時刻(yyyy-MM-dd)がパラメータ以降であるかどうか|
|until:|最終実行の終了時刻(yyyy-MM-dd)がパラメータ以前であるかどうか|

##### Example

encoded

```
GET /:app-name/jobs?q=send%20mail%20since%3a2000%2d01%2d01%20until%3a2100%2d01%2d01
```

not encoded

```
GET /:app-name/jobs?q=send mail since:2000-01-01 until:2100-01-01
```

job名に　send か mail を含み jobの最終実行が2000-01-01から2100-01-01のjobが得られます。

### Create a job

```
POST /:app-name/jobs
```

#### Parameters

|Name|Type|Description|
|----|----|-----------|
|job/name|String|Required. The name of the job.|
|job/components|Map|Required. The components of the job.|
|job/properties|Map|Required but accept null. The properties of the job.|
|step/name|String|Required. The name of the step.|
|step/properties|Map|Required but accept null. The properties of the step.|

#### Example

edn

```clojure
{
  :job/name "example-job"
  :job/components [{
    :step/name "example-step"
    :step/properties nil
    :step/batchlet {
      :batchlet/ref "example.HelloBatch"
      }}]
  :job/properties {:key "value"}}
```

JSON

```JSON
{
  "job/name": "example-job",
  "job/components": [
    {
      "step/name": "example-step",
      "step/properties": null,
      "step/batchlet": {
        "batchlet/ref": "example.HelloBatch"
      }
    }
  ],
  "job/properties": {
      "key": "value"
  }
}
```

### Get a single job

```
GET /:app-name/job/:job-name
```

#### Response

```clojure
{
  :db/id 17592186045451
  :job/stats {
    :total 49
    :success 39
    :failure 3
    :average 2660/39
  }
  :job/schedule {
    :schedule/active? true
    :schedule/cron-notation "0 0 * * * ?"
  }
  :job/restartable? true
  :job/name "MyShell"
  :job/next-execution {
    :job-execution/start-time #inst "2015-04-13T09:00:00.000-00:00"
  }
  :job/latest-execution {
    :job-execution/batch-status {:db/ident :batch-status/queued}
    :job-execution/create-time #inst "2015-04-13T07:00:00.006-00:00"
  }
}
```

### Update a job

```
PUT /:app-name/job/:job-name
```

#### Inputs

reffer [Creare a job](#create-a-job)

### Delete a job

```
DELETE /:app-name/job/:job-name
```

### Create a calendar

```
POST /calendars
```

#### Input

|Name|Type|Description|
|----|----|-----------|
|calendar/name|String|Required. Name of calenar.|
|calendar/weekly-holiday|Array|Required. Weekly holiday of calendar.|
|calendar/holidays|Array|Not Required. Holidays of calendar.|

edn

```clojure
{
  :calendar/name "example"
  :calendar/weekly-holiday [true false false false false false true]
  :calendar/holidays [#inst "2016-09-15T15:00:00.000-00:00"]
  :new? true
}
```

JSON

```JSON
{
  "calendar/name": "example"
  "calendar/weekly-holiday": [true false false false false false true]
  "calendar/holidays" ["2016-09-15"]
  :new? true
}
```

### List calendars

```
GET /calendars
```

### Update calendar
```
PUT /calendar/:calendar-name

```

### Delete calendar

```
DELETE /calendar/:calendar-name
```

### Schedule a job

```
POST /:app-name/job/:job-name/schedule
```

#### Input

|Name|Type|Description|
|----|----|-----------|
|schedule/cron-notation|String|Required. A schedule by the cron notation.|
|schedule/calendar|Map|Not Required. A schedule by calendar.|
|calendar/name|String|Not Required. Name of calendar.|

edn

```clojure
{
 :schedule/cron-notation "0 0 * * * ?", :schedule/calendar {:calendar/name "example"}
}
```

JSON

```JSON
{
 "schedule/cron-notation": "0 0 * * * ?"
 ":schedule/calendar":{
   "calendar/name": "example"
 }
}
```
### Execute a job

```
POST /:app-name/job/:job-name/executions
```

### List executions

```
GET /:app-name/job/:job-name/executions
```

#### Response

```clojure
[
  {
    :db/id 17592186045455
    :job-execution/execution-id 119
    :job-execution/create-time #inst "2015-04-08T04:54:15.703-00:00"
    :job-execution/start-time #inst "2015-04-08T04:55:01.694-00:00"
    :job-execution/end-time #inst "2015-04-08T04:55:01.796-00:00"
    :job-execution/agent {
      :agent/name "agent-1"
      :agent/instance-id #uuid "5424c784-a145-4d3e-96f3-b9d99858611a"
    }
    :job-execution/batch-status {:db/ident :batch-status/completed}
    :job-execution/job-parameters "{}"
  }
]
```

### Delete executions
```
DELETE /:app-name/job/:job-name/executions
```

### Get a single execution

```
GET /:app-name/job/:job-name/execution/:execution-id
```

### Stop a execution

```
PUT /:app-name/job/:job-name/execution/:execution-id/stop
```

### Restart a execution

```
PUT /:app-name/job/:job-name/execution/:execution-id/restart
```

### Abandon a execution

```
PUT /:app-name/job/:job-name/execution/:execution-id/abandon
```

### List agents

```
GET /agents
```

#### Response

```clojure
[{
  :agent/name "agent-1"
  :agent/port 4510
  :agent/jobs {:running 0}
  :command :ready
  :agent/instance-id #uuid "d7dd0172-d272-41a4-aad2-56318b2234ee"
  :agent/cpu-arch "amd64"
  :agent/cpu-core 4
  :agent/os-name "Linux"
  :agent/stats {
    :memory {
      :physical {
        :free 1070014464
        :total 8281976832
      }
      :swap {
        :free 34325999616
        :total 34359734272
      }
    }
    :cpu {
      :process {
        :load 0.024032586558044806
        :time 13050000000
      }
      :system {
        :load 0.07780040733197556
        :load-average 2.43
      }
    }
  }
  :agent/os-version "3.19.3-3-ARCH"
  :agent/host "127.0.0.1"
  :agent/executions []
}]
```

### Get a single agent

```
GET /agent/:instance-id
```

#### Response

```clojure
{
  :agent/name "agent-1"
  :agent/port 4510
  :agent/jobs {:running 0}
  :command :ready
  :agent/instance-id #uuid "d7dd0172-d272-41a4-aad2-56318b2234ee"
  :agent/cpu-arch "amd64"
  :agent/cpu-core 4
  :agent/os-name "Linux"
  :agent/stats {
    :memory {
      :physical {
        :free 1070014464
        :total 8281976832
      }
      :swap {
        :free 34325999616
        :total 34359734272
      }
    }
    :cpu {
      :process {
        :load 0.024032586558044806
        :time 13050000000
      }
      :system {
        :load 0.07780040733197556
        :load-average 2.43
      }
    }
  }
  :agent/os-version "3.19.3-3-ARCH"
  :agent/host "127.0.0.1"
  :agent/executions []
}
```

### Get statistics of control bus

```
GET /:app-name/stats
```

#### Response

```clojure
{:agents 0, :jobs 3}
```

## GitHub
https://github.com/job-streamer/job-streamer-control-bus