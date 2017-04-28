type=page
status=publish
~~~~~~

# 死活監視

JobStreamer の各コンポーネントは死活監視をサポートします。
それぞれのコンポーネントは /healthcheck エンドポイントを持ち、サービスが利用可能な場合 GET リクエストに HTTP Code 200 OK を返します。
サービスが利用できない場合は HTTP Code 503 Service Unavailable を返します。

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
