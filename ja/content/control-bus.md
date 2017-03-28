type=page
status=publish
~~~~~~

# Control-bus

## Control-bus とは？
control-bus は API 呼び出しを制御します。
すべての API 呼び出しは control-bus を介して行います。
そのため、直接 console -> agent といった APIアクセス が発生することはありません。

## Control-bus で出来ること
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

## Control-bus API
Control-bus は REST API を提供します。
POST/PUT 時のパラメータは edn 形式と JSON 形式に対応しています。

### 認証
全ての API の実行には認証が必要です。
API 呼び出し時の認証方法については [認証認可#API 実行時の認証](./auth.html) を参照してください

### アプリケーション作成

```
POST /apps
```

#### 例

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

> JobStreamer は現状では単一のアプリケーション (アプリケーション名: default) にした対応していません。

### ジョブ一覧取得

```
GET /:app-name/jobs
```

#### 検索クエリ
job を条件検索したい場合は以下のようにパラメータを付加することでできます。

```
GET /:app-name/jobs?q=[query]
```

query では基本的にスペース区切りで job 名を指定することで部分一致検索を行います。
それ以外にもプレフィックスをつけることで様々な検索が可能です。

|prefix|Description|
|----|-----------|
|exit-status:|最終実行の exit-status と指定値が部分一致するかどうか|
|since:|最終実行の終了時刻 (yyyy-MM-dd) が指定値以降であるかどうか|
|until:|最終実行の終了時刻 (yyyy-MM-dd) が指定値以前であるかどうか|

##### 例
job 名に "send" か "mail" を含み job の最終実行が 2000-01-01 から 2100-01-01 の job を検索するクエリ

```
send mail since:2000-01-01 until:2100-01-01
```

API を呼び出す際には URL エンコーディングして渡します。

```
GET /:app-name/jobs?q=send%20mail%20since%3a2000%2d01%2d01%20until%3a2100%2d01%2d01
```

### ~~ジョブ作成~~
***この API は現在使用することが出来ません***

```
POST /:app-name/jobs
```

#### パラメータ

|Name|Type|Description|
|----|----|-----------|
|job/name|String|Required. The name of the job.|
|job/components|Map|Required. The components of the job.|
|job/properties|Map|Required but accept null. The properties of the job.|
|step/name|String|Required. The name of the step.|
|step/properties|Map|Required but accept null. The properties of the step.|

##### 例: edn 形式

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

##### 例: JSON 形式

```json
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

### 単一ジョブ取得

```
GET /:app-name/job/:job-name
```

#### レスポンス

```clojure
{:db/id 17592186062189
 :job/name "test"
 :job/next-execution nil
 :job/exclusive? false
 :job/stats {:total 12
             :success 12
             :failure 0
             :average 27/4}
 :job/bpmn-xml-notation "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<bpmn:definitions xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:bpmn=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:jsr352=\"http://jsr352/\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:dc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:di=\"http://www.omg.org/spec/DD/20100524/DI\" id=\"Definitions_1\" targetNamespace=\"http://bpmn.io/schema/bpmn\">\n  <jsr352:job id=\"Job_1\" bpmn:name=\"test\" isExecutable=\"false\">\n    <jsr352:start id=\"Start_1\">\n      <bpmn:outgoing>Transition_1i7cmsw</bpmn:outgoing>\n    </jsr352:start>\n    <jsr352:step id=\"Step_1j4854h\">\n      <bpmn:incoming>Transition_1i7cmsw</bpmn:incoming>\n    </jsr352:step>\n    <jsr352:transition id=\"Transition_1i7cmsw\" sourceRef=\"Start_1\" targetRef=\"Step_1j4854h\" />\n  </jsr352:job>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_1\" bpmnElement=\"Job_1\">\n      <bpmndi:BPMNShape id=\"_BPMNShape_Start_2\" bpmnElement=\"Start_1\">\n        <dc:Bounds x=\"173\" y=\"102\" width=\"36\" height=\"36\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Step_1j4854h_di\" bpmnElement=\"Step_1j4854h\">\n        <dc:Bounds x=\"241\" y=\"110\" width=\"120\" height=\"100\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge id=\"Transition_1i7cmsw_di\" bpmnElement=\"Transition_1i7cmsw\">\n        <di:waypoint xsi:type=\"dc:Point\" x=\"209\" y=\"120\" />\n        <di:waypoint xsi:type=\"dc:Point\" x=\"225\" y=\"120\" />\n        <di:waypoint xsi:type=\"dc:Point\" x=\"225\" y=\"152\" />\n        <di:waypoint xsi:type=\"dc:Point\" x=\"241\" y=\"152\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"240\" y=\"126\" width=\"0\" height=\"0\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</bpmn:definitions>\n"
 :job/svg-notation "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<!-- created with bpmn-js / http://bpmn.io -->\n<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"200\" height=\"120\" viewBox=\"167 96 200 120\" version=\"1.1\"><defs><marker id=\"sequenceflow-end\" viewBox=\"0 0 20 20\" refX=\"11\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 1 5 L 11 10 L 1 15 Z\" style=\"fill: black; stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1;\"></path></marker><marker id=\"messageflow-start\" viewBox=\"0 0 20 20\" refX=\"6\" refY=\"6\" markerWidth=\"20\" markerHeight=\"20\" orient=\"auto\"><circle cx=\"6\" cy=\"6\" r=\"3.5\" style=\"fill: white; stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></circle></marker><marker id=\"messageflow-end\" viewBox=\"0 0 20 20\" refX=\"8.5\" refY=\"5\" markerWidth=\"20\" markerHeight=\"20\" orient=\"auto\"><path d=\"m 1 5 l 0 -3 l 7 3 l -7 3 z\" style=\"fill: white; stroke-width: 1px; stroke-linecap: butt; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker><marker id=\"association-start\" viewBox=\"0 0 20 20\" refX=\"1\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 11 5 L 1 10 L 11 15\" style=\"fill: none; stroke-width: 1.5px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker><marker id=\"association-end\" viewBox=\"0 0 20 20\" refX=\"12\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 1 5 L 11 10 L 1 15\" style=\"fill: none; stroke-width: 1.5px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker><marker id=\"conditional-flow-marker\" viewBox=\"0 0 20 20\" refX=\"-1\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 0 10 L 8 6 L 16 10 L 8 14 Z\" style=\"fill: white; stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker><marker id=\"conditional-default-flow-marker\" viewBox=\"0 0 20 20\" refX=\"-5\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 1 4 L 5 16\" style=\"fill: black; stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker></defs><g class=\"djs-group\"><g class=\"djs-element djs-shape\" data-element-id=\"Start_1\" style=\"display: block;\" transform=\"translate(173 102)\"><g class=\"djs-visual\"><circle cx=\"18\" cy=\"18\" r=\"18\" style=\"stroke: black; stroke-width: 2px; fill: white;\"/></g><rect x=\"0\" y=\"0\" width=\"36\" height=\"36\" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"-6\" y=\"-6\" width=\"48\" height=\"48\" class=\"djs-outline\" style=\"fill: none;\"/></g></g><g class=\"djs-group\"><g class=\"djs-element djs-shape\" data-element-id=\"Start_1_label\" style=\"display: none;\" transform=\"translate(191 138)\"><g class=\"djs-visual\"><text class=\"djs-label\" transform=\"translate(0,0)\" style=\"font-family: Arial, sans-serif; font-size: 11px;\"><tspan x=\"45\" y=\"12\"/></text></g><rect x=\"0\" y=\"0\" width=\"0\" height=\"0\" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"-6\" y=\"-6\" width=\"12\" height=\"12\" class=\"djs-outline\" style=\"fill: none;\"/></g></g><g class=\"djs-group\"><g class=\"djs-element djs-shape\" data-element-id=\"Step_1j4854h\" style=\"display: block;\" transform=\"translate(241 110)\"><g class=\"djs-visual\"><rect x=\"0\" y=\"0\" width=\"120\" height=\"100\" rx=\"10\" ry=\"10\" style=\"stroke: black; stroke-width: 2px; fill: white;\"/><rect x=\"0\" y=\"0\" width=\"40\" height=\"20\" rx=\"0\" ry=\"0\" style=\"stroke: black; stroke-width: 2px; fill: white;\"/><text style=\"font-family: Arial, sans-serif; font-size: 12px; fill: rgb(0, 0, 0);\"><tspan x=\"7.5\" y=\"13.5\">Step</tspan></text><text style=\"font-family: Arial, sans-serif; font-size: 12px;\"><tspan x=\"60\" y=\"15\"/></text></g><rect x=\"0\" y=\"0\" width=\"120\" height=\"100\" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"-6\" y=\"-6\" width=\"132\" height=\"112\" class=\"djs-outline\" style=\"fill: none;\"/></g></g><g class=\"djs-group\"><g class=\"djs-element djs-connection\" data-element-id=\"Transition_1i7cmsw\" style=\"display: block;\"><g class=\"djs-visual\"><path d=\"m  209,120L225,120 L225,152 L241,152 \" style=\"fill: none; stroke-width: 2px; stroke: black; stroke-linejoin: round; marker-end: url('#sequenceflow-end');\"/></g><polyline points=\"209,120 225,120 225,152 241,152 \" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"203\" y=\"114\" width=\"44\" height=\"44\" class=\"djs-outline\" style=\"fill: none;\"/></g></g><g class=\"djs-group\"><g class=\"djs-element djs-shape\" data-element-id=\"Transition_1i7cmsw_label\" style=\"display: none;\" transform=\"translate(240 126)\"><g class=\"djs-visual\"><text class=\"djs-label\" transform=\"translate(0,0)\" style=\"font-family: Arial, sans-serif; font-size: 11px;\"><tspan x=\"45\" y=\"12\"/></text></g><rect x=\"0\" y=\"0\" width=\"0\" height=\"0\" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"-6\" y=\"-6\" width=\"12\" height=\"12\" class=\"djs-outline\" style=\"fill: none;\"/></g></g></svg>"
 :job/dynamic-parameters #{}
 :job/latest-execution{:db/id 17592189204505
                       :job-execution/start-time #inst "2017-03-27T01:10:36.339-00:00"
                       :job-execution/end-time #inst "2017-03-27T01:10:36.350-00:00"
                       :job-execution/create-time #inst "2017-03-27T01:09:09.964-00:00"
                       :job-execution/exit-status "COMPLETED"
                       :job-execution/batch-status {:db/ident :batch-status/completed}
                       :job-execution/agent {:agent/name "ip-10-0-2-175"
                                             :agent/instance-id #uuid "5c6e27ba-037b-42aa-91cc-b55eec159bd0"}}}
```

### ~~ジョブ更新~~
***この API は現在使用することが出来ません***

```
PUT /:app-name/job/:job-name
```

#### パラメータ
[ジョブ作成](#ジョブ作成) を参照してください。

### ジョブ削除

```
DELETE /:app-name/job/:job-name
```

### カレンダー作成

```
POST /calendars
```

#### パラメータ

|Name|Type|Description|
|----|----|-----------|
|calendar/name|String|Required. Name of calenar.|
|calendar/weekly-holiday|Array|Required. Weekly holiday of calendar.|
|calendar/holidays|Array|Not Required. Holidays of calendar.|

##### 例: edn 形式

```clojure
{
  :calendar/name "example"
  :calendar/weekly-holiday [true false false false false false true]
  :calendar/holidays [#inst "2016-09-15T15:00:00.000-00:00"]
  :new? true
}
```

##### 例: JSON 形式

```json
{
  "calendar/name": "example"
  "calendar/weekly-holiday": [true false false false false false true]
  "calendar/holidays" ["2016-09-15"]
  :new? true
}
```

### カレンダー一覧取得

```
GET /calendars
```

### カレンダー更新

```
PUT /calendar/:calendar-name
```

### カレンダー削除

```
DELETE /calendar/:calendar-name
```

#### パラメータ
[カレンダー作成](#カレンダー作成) を参照してください。

### ジョブ実行スケジュール作成
ジョブに対する実行スケジュールを作成します。
実行スケジュールの詳細は [ジョブのスケジューリング](./schedule-job.html) を参照して下さい。

```
POST /:app-name/job/:job-name/schedule
```

#### パラメータ

|Name|Type|Description|
|----|----|-----------|
|schedule/cron-notation|String|Required. A schedule by the cron notation.|
|schedule/calendar|Map|Not Required. A schedule by calendar.|
|calendar/name|String|Not Required. Name of calendar.|


##### 例: edn 形式

```clojure
{
 :schedule/cron-notation "0 0 * * * ?", :schedule/calendar {:calendar/name "example"}
}
```

##### 例: JSON 形式

```json
{
 "schedule/cron-notation": "0 0 * * * ?"
 ":schedule/calendar":{
   "calendar/name": "example"
 }
}
```

### ジョブ実行

```
POST /:app-name/job/:job-name/executions
```

### ジョブ実行履歴一覧取得

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

### ジョブ実行履歴削除

```
DELETE /:app-name/job/:job-name/executions
```

### ジョブ実行履歴取得

```
GET /:app-name/job/:job-name/execution/:execution-id
```

### ジョブ実行一時停止

```
PUT /:app-name/job/:job-name/execution/:execution-id/stop
```

### ジョブ実行再開

```
PUT /:app-name/job/:job-name/execution/:execution-id/restart
```

### ジョブ実行破棄

```
PUT /:app-name/job/:job-name/execution/:execution-id/abandon
```

### 実行エージェント一覧取得

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

### 実行エージェント取得

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

### Control-bus 統計情報取得

```
GET /:app-name/stats
```

#### Response

```clojure
{:agents 0, :jobs 3}
```

## GitHub
https://github.com/job-streamer/job-streamer-control-bus