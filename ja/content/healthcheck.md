type=page
status=publish
~~~~~~

# 死活監視

JobStreamer の各コンポーネントは死活監視をサポートします。
それぞれのコンポーネントは /healthcheck エンドポイントを持ち、サービスが利用可能な場合 GET リクエストに HTTP Code 200 OK を返します。
サービスが利用できない場合は HTTP Code 503 Service Unavailable を返します。

この機能は下記のバージョンのコンポーネントで利用可能です。

| component                | version |
| ------------------------ | ------- |
| job-streamer-control-bus | >=1.0.8 |
| job-streamer-console     | >=1.0.4 |
| job-streamer-agent       | >=1.0.7 |
| job-streamer-notificator | >=1.0.2 |

## control-bus

```
GET [control-bus host]:[CONTROL_BUS_PORT]/healthcheck
200
```

datomic への接続がない場合、

```
GET [control-bus host]:[CONTROL_BUS_PORT]/healthcheck
503
```

## console

```
GET [console host]:[CONSOLE_PORT]/healthcheck
200
```

## agent

```
GET [agent host]:[AGENT_PORT]/healthcheck
200
```

## notificator

```
GET [notificator host]:[NOTIFICATOR_PORT]/healthcheck
200
```
