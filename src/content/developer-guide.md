type=page
status=publish
~~~~~~

# Developer guide for contributors

## Format policy

-   All of exchange data is done using [EDN Format](https://github.com/edn-format/edn).(In comparison with the JSON, there is an advantage that it is possible to have a type of `Date` and `UUID` .)
-   Map key in EDN is keyword with entity's name-space. (Easy to understand when see only data.)

## Interface policy

-   Both Agent and Control bus use REST API as interface.(for enable tool-development Other than Console)
-   Must call from Control bus to Agent API.Don't call reverse.

## Connection policy

-   In order to improve responsibility of Agent, WebSocket connects bus from agent to Control.
-   Consideration of failure, WebSocket doesn't exchange data, only notification.
-   Monitoring dead-or-alive and performance of Agent is done through WebSocket.
-   In order to make Agent be no configuration, it detects Control bus address automatically.
    1.  Agent broadcast its own address when process starts.
    2.  When Control bus catches broadcast from Agent, send connection
        request to Agent.
    3.  Agent that receive connection request tries to connect control bus
        on WebSocket.
-   When close connection from Agent to Control bus, Agent restart broadcast, so that even if switch Control bus stand-by, switch connection automatically.

## Persitence policy

-   All data flowing at Control bus are stored in Datomic.
-   Accessing to Datomic is allowed only from Control bus.

## If you want more safely structure

-   Because [WebSocketClassLoader](https://github.com/kawasima/websocket-classloader) is eccentric structure, enable using application deploying to Agent.
    In this case, if bypass ClassLoder configuation, Agent's local context ClassLoader is used.
    In this way, enable to use JobStreamer as job scheduler.
-   Job's execution log is sent to Control bus and stored in Datomic in the default setting.
-   Depending on logback setting, be able to write log into local file of Agent or Control bus.
