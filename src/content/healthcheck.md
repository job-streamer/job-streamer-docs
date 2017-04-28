type=page
status=publish
~~~~~~

# Healthcheck

JobStreamer supports healthcheck.
Each components has /healthcheck endpoint and they return HTTP Code 200 OK to GET request if service is available.
They return HTTP Code 503 Service Unavailable if service is unavailable.

## control-bus

```
GET [control-bus host]:[CONTROL_BUS_PORT]/healthcheck
200
```

If it losts datomic connection,

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
