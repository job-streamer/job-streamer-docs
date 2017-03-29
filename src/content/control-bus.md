type=page
status=publish
~~~~~~

# Control bus
Control-bus controls API calls.
All API calls are executed via Control-bus.
In this reason, direct API access like console -> agent never occurs.

## What Control bus can do
* Deploy batch components
* Regist job
* Delete job
* Change job

* Execute job
* Stop job
* Restart job

* Regist calendar
* Delete calendar
* Change calendar

* Schedule job
* Stop job schedule
* Delete job schedule

## Control bus API
Control-bus provides REST API.
POST/PUT parameters correspond to end format and JSON format.

### Authentication
All API calls need authentication.
Please refer to [Authentification and authorization#Authentification in API execution](./auth.html#Authentification in API execution) about it.

### Create application

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

> Now, JobStreamer corresponds to only single application (named "default").

### List jobs

```
GET /:app-name/jobs
```

#### Search
If you want to search jobs with a condition, you can specify URL parameters like following.

```
GET /:app-name/jobs?q=[query]&with=[with]&sort-by=[sort-by]&limit=[limit]&offset=[offset]
```

##### 1. query
If you specify this, you can perform partial match search by job name with space delimiters.
You can perform various searchs by using following prefixes.

|prefix|Description|
|----|-----------|
|exit-status:|Whther or not the exit-status of the latest execution matches the specified value.|
|since:|Whther or not the start date of the latest execution is after the specified value.|
|until:|Whther or not the finish date of the latest execution is before the specified value.|

* Example

```
query=send mail since:2000-01-01 until:2100-01-01
```

##### 2. with
Specify job attribute names you want to get as result with space delimiters.
You can specify following attribute names.

||Description|
|----|-----------|
| execution |Get executions of the job|
| schedule  |Get schedule of the job|
| notation  |Get xml and svg notations of the job|
| settings  |Get settings of the job|

* Example

```
with=execution,schedule
```

##### 3. sort-by
Specify sort key.
Specify key name and asc/desc as a set of collon sperated value.
If you specify multiple sort keys, join them in order priority with comma separators.
You can specify following sort keys.

||Description|
|----|-----------|
| name                    | Job name |
| last-execution-started  | Start date time of the latest execution |
| last-execution-duration | Duration of the latest execution |
| last-execution-status   | Exit status of the latest execution |
| next-execution-start    | Start date time of the next execution |

* Example

```
sort-by=name:asc,last-execution-status:desc
```

##### 4. limit
Search limit.

##### 5. offset
Search offset to implemant paging.

##### Example
A query that searchs job whoes name includes "send" or "mail" and whose latest execution is between 2000-01-01 and 2100-01-01.

```
send mail since:2000-01-01 until:2100-01-01
```

You have to encode it when calling API.

```
GET /:app-name/jobs?q=send%20mail%20since%3a2000%2d01%2d01%20until%3a2100%2d01%2d01
```

### Create job

```
POST /:app-name/jobs
```

#### Parameter

| Name                  | Type   | Description |
|-----------------------|--------|-------------|
| job/name              | String | Required. Job name |
| job/bpmn-xml-notation | String | Required. Job body formatted as BPMN |
| job/svg-notation      | String | Required. Job svg string |

##### Ecample: edn format

```clojure
{
  :job/name "example-job"
  :job/bpmn-xml-notation "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<bpmn:definitions xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:bpmn=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:jsr352=\"http://jsr352/\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:dc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:di=\"http://www.omg.org/spec/DD/20100524/DI\" id=\"Definitions_1\" targetNamespace=\"http://bpmn.io/schema/bpmn\">\n  <jsr352:job id=\"Job_1\" bpmn:name=\"test\" isExecutable=\"false\">\n    <jsr352:start id=\"Start_1\">\n      <bpmn:outgoing>Transition_1i7cmsw</bpmn:outgoing>\n    </jsr352:start>\n    <jsr352:step id=\"Step_1j4854h\">\n      <bpmn:incoming>Transition_1i7cmsw</bpmn:incoming>\n    </jsr352:step>\n    <jsr352:transition id=\"Transition_1i7cmsw\" sourceRef=\"Start_1\" targetRef=\"Step_1j4854h\" />\n  </jsr352:job>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_1\" bpmnElement=\"Job_1\">\n      <bpmndi:BPMNShape id=\"_BPMNShape_Start_2\" bpmnElement=\"Start_1\">\n        <dc:Bounds x=\"173\" y=\"102\" width=\"36\" height=\"36\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Step_1j4854h_di\" bpmnElement=\"Step_1j4854h\">\n        <dc:Bounds x=\"241\" y=\"110\" width=\"120\" height=\"100\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge id=\"Transition_1i7cmsw_di\" bpmnElement=\"Transition_1i7cmsw\">\n        <di:waypoint xsi:type=\"dc:Point\" x=\"209\" y=\"120\" />\n        <di:waypoint xsi:type=\"dc:Point\" x=\"225\" y=\"120\" />\n        <di:waypoint xsi:type=\"dc:Point\" x=\"225\" y=\"152\" />\n        <di:waypoint xsi:type=\"dc:Point\" x=\"241\" y=\"152\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"240\" y=\"126\" width=\"0\" height=\"0\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</bpmn:definitions>\n"
  :job/svg-notation "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<!-- created with bpmn-js / http://bpmn.io -->\n<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"200\" height=\"120\" viewBox=\"167 96 200 120\" version=\"1.1\"><defs><marker id=\"sequenceflow-end\" viewBox=\"0 0 20 20\" refX=\"11\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 1 5 L 11 10 L 1 15 Z\" style=\"fill: black; stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1;\"></path></marker><marker id=\"messageflow-start\" viewBox=\"0 0 20 20\" refX=\"6\" refY=\"6\" markerWidth=\"20\" markerHeight=\"20\" orient=\"auto\"><circle cx=\"6\" cy=\"6\" r=\"3.5\" style=\"fill: white; stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></circle></marker><marker id=\"messageflow-end\" viewBox=\"0 0 20 20\" refX=\"8.5\" refY=\"5\" markerWidth=\"20\" markerHeight=\"20\" orient=\"auto\"><path d=\"m 1 5 l 0 -3 l 7 3 l -7 3 z\" style=\"fill: white; stroke-width: 1px; stroke-linecap: butt; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker><marker id=\"association-start\" viewBox=\"0 0 20 20\" refX=\"1\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 11 5 L 1 10 L 11 15\" style=\"fill: none; stroke-width: 1.5px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker><marker id=\"association-end\" viewBox=\"0 0 20 20\" refX=\"12\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 1 5 L 11 10 L 1 15\" style=\"fill: none; stroke-width: 1.5px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker><marker id=\"conditional-flow-marker\" viewBox=\"0 0 20 20\" refX=\"-1\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 0 10 L 8 6 L 16 10 L 8 14 Z\" style=\"fill: white; stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker><marker id=\"conditional-default-flow-marker\" viewBox=\"0 0 20 20\" refX=\"-5\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 1 4 L 5 16\" style=\"fill: black; stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker></defs><g class=\"djs-group\"><g class=\"djs-element djs-shape\" data-element-id=\"Start_1\" style=\"display: block;\" transform=\"translate(173 102)\"><g class=\"djs-visual\"><circle cx=\"18\" cy=\"18\" r=\"18\" style=\"stroke: black; stroke-width: 2px; fill: white;\"/></g><rect x=\"0\" y=\"0\" width=\"36\" height=\"36\" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"-6\" y=\"-6\" width=\"48\" height=\"48\" class=\"djs-outline\" style=\"fill: none;\"/></g></g><g class=\"djs-group\"><g class=\"djs-element djs-shape\" data-element-id=\"Start_1_label\" style=\"display: none;\" transform=\"translate(191 138)\"><g class=\"djs-visual\"><text class=\"djs-label\" transform=\"translate(0,0)\" style=\"font-family: Arial, sans-serif; font-size: 11px;\"><tspan x=\"45\" y=\"12\"/></text></g><rect x=\"0\" y=\"0\" width=\"0\" height=\"0\" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"-6\" y=\"-6\" width=\"12\" height=\"12\" class=\"djs-outline\" style=\"fill: none;\"/></g></g><g class=\"djs-group\"><g class=\"djs-element djs-shape\" data-element-id=\"Step_1j4854h\" style=\"display: block;\" transform=\"translate(241 110)\"><g class=\"djs-visual\"><rect x=\"0\" y=\"0\" width=\"120\" height=\"100\" rx=\"10\" ry=\"10\" style=\"stroke: black; stroke-width: 2px; fill: white;\"/><rect x=\"0\" y=\"0\" width=\"40\" height=\"20\" rx=\"0\" ry=\"0\" style=\"stroke: black; stroke-width: 2px; fill: white;\"/><text style=\"font-family: Arial, sans-serif; font-size: 12px; fill: rgb(0, 0, 0);\"><tspan x=\"7.5\" y=\"13.5\">Step</tspan></text><text style=\"font-family: Arial, sans-serif; font-size: 12px;\"><tspan x=\"60\" y=\"15\"/></text></g><rect x=\"0\" y=\"0\" width=\"120\" height=\"100\" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"-6\" y=\"-6\" width=\"132\" height=\"112\" class=\"djs-outline\" style=\"fill: none;\"/></g></g><g class=\"djs-group\"><g class=\"djs-element djs-connection\" data-element-id=\"Transition_1i7cmsw\" style=\"display: block;\"><g class=\"djs-visual\"><path d=\"m  209,120L225,120 L225,152 L241,152 \" style=\"fill: none; stroke-width: 2px; stroke: black; stroke-linejoin: round; marker-end: url('#sequenceflow-end');\"/></g><polyline points=\"209,120 225,120 225,152 241,152 \" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"203\" y=\"114\" width=\"44\" height=\"44\" class=\"djs-outline\" style=\"fill: none;\"/></g></g><g class=\"djs-group\"><g class=\"djs-element djs-shape\" data-element-id=\"Transition_1i7cmsw_label\" style=\"display: none;\" transform=\"translate(240 126)\"><g class=\"djs-visual\"><text class=\"djs-label\" transform=\"translate(0,0)\" style=\"font-family: Arial, sans-serif; font-size: 11px;\"><tspan x=\"45\" y=\"12\"/></text></g><rect x=\"0\" y=\"0\" width=\"0\" height=\"0\" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"-6\" y=\"-6\" width=\"12\" height=\"12\" class=\"djs-outline\" style=\"fill: none;\"/></g></g></svg>"}
}
```

##### Example: JSON format

```JSON
{
  "job/name": "example-job",
  "job/bpmn-xml-notation": "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<bpmn:definitions xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:bpmn=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:jsr352=\"http://jsr352/\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:dc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:di=\"http://www.omg.org/spec/DD/20100524/DI\" id=\"Definitions_1\" targetNamespace=\"http://bpmn.io/schema/bpmn\">\n  <jsr352:job id=\"Job_1\" bpmn:name=\"test\" isExecutable=\"false\">\n    <jsr352:start id=\"Start_1\">\n      <bpmn:outgoing>Transition_1i7cmsw</bpmn:outgoing>\n    </jsr352:start>\n    <jsr352:step id=\"Step_1j4854h\">\n      <bpmn:incoming>Transition_1i7cmsw</bpmn:incoming>\n    </jsr352:step>\n    <jsr352:transition id=\"Transition_1i7cmsw\" sourceRef=\"Start_1\" targetRef=\"Step_1j4854h\" />\n  </jsr352:job>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_1\" bpmnElement=\"Job_1\">\n      <bpmndi:BPMNShape id=\"_BPMNShape_Start_2\" bpmnElement=\"Start_1\">\n        <dc:Bounds x=\"173\" y=\"102\" width=\"36\" height=\"36\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Step_1j4854h_di\" bpmnElement=\"Step_1j4854h\">\n        <dc:Bounds x=\"241\" y=\"110\" width=\"120\" height=\"100\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge id=\"Transition_1i7cmsw_di\" bpmnElement=\"Transition_1i7cmsw\">\n        <di:waypoint xsi:type=\"dc:Point\" x=\"209\" y=\"120\" />\n        <di:waypoint xsi:type=\"dc:Point\" x=\"225\" y=\"120\" />\n        <di:waypoint xsi:type=\"dc:Point\" x=\"225\" y=\"152\" />\n        <di:waypoint xsi:type=\"dc:Point\" x=\"241\" y=\"152\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"240\" y=\"126\" width=\"0\" height=\"0\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</bpmn:definitions>\n",
  "job/svg-notation": "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<!-- created with bpmn-js / http://bpmn.io -->\n<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"200\" height=\"120\" viewBox=\"167 96 200 120\" version=\"1.1\"><defs><marker id=\"sequenceflow-end\" viewBox=\"0 0 20 20\" refX=\"11\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 1 5 L 11 10 L 1 15 Z\" style=\"fill: black; stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1;\"></path></marker><marker id=\"messageflow-start\" viewBox=\"0 0 20 20\" refX=\"6\" refY=\"6\" markerWidth=\"20\" markerHeight=\"20\" orient=\"auto\"><circle cx=\"6\" cy=\"6\" r=\"3.5\" style=\"fill: white; stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></circle></marker><marker id=\"messageflow-end\" viewBox=\"0 0 20 20\" refX=\"8.5\" refY=\"5\" markerWidth=\"20\" markerHeight=\"20\" orient=\"auto\"><path d=\"m 1 5 l 0 -3 l 7 3 l -7 3 z\" style=\"fill: white; stroke-width: 1px; stroke-linecap: butt; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker><marker id=\"association-start\" viewBox=\"0 0 20 20\" refX=\"1\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 11 5 L 1 10 L 11 15\" style=\"fill: none; stroke-width: 1.5px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker><marker id=\"association-end\" viewBox=\"0 0 20 20\" refX=\"12\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 1 5 L 11 10 L 1 15\" style=\"fill: none; stroke-width: 1.5px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker><marker id=\"conditional-flow-marker\" viewBox=\"0 0 20 20\" refX=\"-1\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 0 10 L 8 6 L 16 10 L 8 14 Z\" style=\"fill: white; stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker><marker id=\"conditional-default-flow-marker\" viewBox=\"0 0 20 20\" refX=\"-5\" refY=\"10\" markerWidth=\"10\" markerHeight=\"10\" orient=\"auto\"><path d=\"M 1 4 L 5 16\" style=\"fill: black; stroke-width: 1px; stroke-linecap: round; stroke-dasharray: 10000, 1; stroke: black;\"></path></marker></defs><g class=\"djs-group\"><g class=\"djs-element djs-shape\" data-element-id=\"Start_1\" style=\"display: block;\" transform=\"translate(173 102)\"><g class=\"djs-visual\"><circle cx=\"18\" cy=\"18\" r=\"18\" style=\"stroke: black; stroke-width: 2px; fill: white;\"/></g><rect x=\"0\" y=\"0\" width=\"36\" height=\"36\" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"-6\" y=\"-6\" width=\"48\" height=\"48\" class=\"djs-outline\" style=\"fill: none;\"/></g></g><g class=\"djs-group\"><g class=\"djs-element djs-shape\" data-element-id=\"Start_1_label\" style=\"display: none;\" transform=\"translate(191 138)\"><g class=\"djs-visual\"><text class=\"djs-label\" transform=\"translate(0,0)\" style=\"font-family: Arial, sans-serif; font-size: 11px;\"><tspan x=\"45\" y=\"12\"/></text></g><rect x=\"0\" y=\"0\" width=\"0\" height=\"0\" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"-6\" y=\"-6\" width=\"12\" height=\"12\" class=\"djs-outline\" style=\"fill: none;\"/></g></g><g class=\"djs-group\"><g class=\"djs-element djs-shape\" data-element-id=\"Step_1j4854h\" style=\"display: block;\" transform=\"translate(241 110)\"><g class=\"djs-visual\"><rect x=\"0\" y=\"0\" width=\"120\" height=\"100\" rx=\"10\" ry=\"10\" style=\"stroke: black; stroke-width: 2px; fill: white;\"/><rect x=\"0\" y=\"0\" width=\"40\" height=\"20\" rx=\"0\" ry=\"0\" style=\"stroke: black; stroke-width: 2px; fill: white;\"/><text style=\"font-family: Arial, sans-serif; font-size: 12px; fill: rgb(0, 0, 0);\"><tspan x=\"7.5\" y=\"13.5\">Step</tspan></text><text style=\"font-family: Arial, sans-serif; font-size: 12px;\"><tspan x=\"60\" y=\"15\"/></text></g><rect x=\"0\" y=\"0\" width=\"120\" height=\"100\" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"-6\" y=\"-6\" width=\"132\" height=\"112\" class=\"djs-outline\" style=\"fill: none;\"/></g></g><g class=\"djs-group\"><g class=\"djs-element djs-connection\" data-element-id=\"Transition_1i7cmsw\" style=\"display: block;\"><g class=\"djs-visual\"><path d=\"m  209,120L225,120 L225,152 L241,152 \" style=\"fill: none; stroke-width: 2px; stroke: black; stroke-linejoin: round; marker-end: url('#sequenceflow-end');\"/></g><polyline points=\"209,120 225,120 225,152 241,152 \" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"203\" y=\"114\" width=\"44\" height=\"44\" class=\"djs-outline\" style=\"fill: none;\"/></g></g><g class=\"djs-group\"><g class=\"djs-element djs-shape\" data-element-id=\"Transition_1i7cmsw_label\" style=\"display: none;\" transform=\"translate(240 126)\"><g class=\"djs-visual\"><text class=\"djs-label\" transform=\"translate(0,0)\" style=\"font-family: Arial, sans-serif; font-size: 11px;\"><tspan x=\"45\" y=\"12\"/></text></g><rect x=\"0\" y=\"0\" width=\"0\" height=\"0\" class=\"djs-hit\" style=\"fill: none; stroke-opacity: 0; stroke: white; stroke-width: 15px;\"/><rect x=\"-6\" y=\"-6\" width=\"12\" height=\"12\" class=\"djs-outline\" style=\"fill: none;\"/></g></g></svg>"
}
```

### Get a single job

```
GET /:app-name/job/:job-name
```

#### Response

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

### Change job

```
PUT /:app-name/job/:job-name
```

#### Parameter
Please refer to [Create job](#Create job).

### Delete job

```
DELETE /:app-name/job/:job-name
```

### Create calendar

```
POST /calendars
```

#### Parameter

|Name|Type|Description|
|----|----|-----------|
|calendar/name|String|Required. Name of calenar.|
|calendar/weekly-holiday|Array|Required. Weekly holiday of calendar.|
|calendar/holidays|Array|Not Required. Holidays of calendar.|
|calendar/day-start|String|Not Required (default: 00:00). Time when a day start.|

##### Example: edn format

```clojure
{
  :calendar/name "example"
  :calendar/weekly-holiday [true false false false false false true]
  :calendar/holidays [#inst "2016-09-15T15:00:00.000-00:00"]
  :calendar/day-start "01:00"
  :new? true
}
```

##### Example: JSON format

```JSON
{
  "calendar/name": "example",
  "calendar/weekly-holiday": [true false false false false false true],
  "calendar/holidays" ["2016-09-15"],
  "calendar/day-start": "01:00",
  :new? true
}
```

### List calendars

```
GET /calendars
```

### Change calendar

```
PUT /calendar/:calendar-name
```

### Delete calendar

```
DELETE /calendar/:calendar-name
```

#### Parameter
[Create calendar](#Create calendar) を参照してください。

### Create job schedule
You can create job execution calendar.
Please refer to [Schedule job](./schedule-job.html) for details.

```
POST /:app-name/job/:job-name/schedule
```

#### Parameter

|Name|Type|Description|
|----|----|-----------|
|schedule/cron-notation|String|Required. Cron notation of the schedule.|
|schedule/calendar|Map|Not Required. Calendar of the schedule.|
|calendar/name|String|Not Required. Name of the calendar.|

##### Example: edn format

```clojure
{
 :schedule/cron-notation "0 0 * * * ?", :schedule/calendar {:calendar/name "example"}
}
```

##### Example: JSON format

```JSON
{
 "schedule/cron-notation": "0 0 * * * ?",
 ":schedule/calendar":{
   "calendar/name": "example"
 }
}
```

### Execute job

```
POST /:app-name/job/:job-name/executions
```

#### Parameter
If target job has parameters, you can submit them as a POST body.
Refer to [Create job](./create-a-job.html) about how to set job parameter.

|Name|Type|Description|
|----|----|-----------|
|[parameter name]|String|Not Required. Parameter for job|

##### Example: edn format

```clojure
{
  :job-param1 "test"
  :job-param2 "test"
}
```

##### Example: JSON format

```JSON
{
  "job-param1": "test",
  "job-param2": "test"
}
```

### List job execution histories

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

### Delete job execution history

```
DELETE /:app-name/job/:job-name/executions
```

### Get job execution history

```
GET /:app-name/job/:job-name/execution/:execution-id
```

### Stop job execution

```
PUT /:app-name/job/:job-name/execution/:execution-id/stop
```

### Restart job execution

```
PUT /:app-name/job/:job-name/execution/:execution-id/restart
```

### Abandon job execution

```
PUT /:app-name/job/:job-name/execution/:execution-id/abandon
```

### List execution agents

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

### Get execution agent

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

### Get Control-bus statictics information

```
GET /:app-name/stats
```

#### Response

```clojure
{:agents 0, :jobs 3}
```

## GitHub
https://github.com/job-streamer/job-streamer-control-bus
