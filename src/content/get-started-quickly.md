type=page
status=publish
~~~~~~

# Quick start
## Control bus
1. Get [datomic-free](https://my.datomic.com/downloads/free)

        % unzip datomic-free-0.9.5394.zip
        % cd datomic-free-0.9.5394
        % bin/transactor config/samples/free-transactor-template.properties

2. Get the latest [Control-bus](https://github.com/job-streamer/job-streamer-control-bus/releases/latest)

3. Run the contorl bus

        % bin/control_bus

4. Environment settings

| Environment variable            | Description | Default value |
|:----------------------------|:----|:----------|
| CONTROL_BUS_PORT            | Port number | 45102 |
| DISCOVERY_PORT              | Port number to listen agent request | 45100 |
| DISCOVERY_ADDRESS           | Multicast IP to listen agent request | (OPTION) |
| NOTIFICATOR_URL             | Notificator URL | http://localhost:2121 |
| ACCESS_CONTROL_ALLOW_ORIGIN | Console URL used by operators | http://localhost:3000 |
| CONTROLE_BUS_RESOURCE_PATH  | Resource path | (OPTION) |

## Console
1. Get the latest [Console](https://github.com/job-streamer/job-streamer-console/releases/latest)

2. Run the console

        % bin/console

3. Environment settings

| Environment variable | Description | Default value |
|:-----------------|:----|:----------|
| CONSOLE_PORT     | Port number | 3000 |
| CONTROL_BUS_URL  | Control-bus URL | http://localhost:45102 |

## Agent
1. Get the latest [Agent](https://github.com/job-streamer/job-streamer-agent/releases/latest)

2. Run the agent

        % bin/agent

3. Environment settings

| Environment variable    | Description | Default value |
|:--------------------|:----|:----------|
| AGENT_PORT          | Port number | 4510 |
| INSTANCE_NAME       | Instance name<br> Specify this if you want to fix it between each start-ups. | (OPTION) |
| DISCOVERY_PORT      | Port number for multicast or broadcast | 45100 |
| DISCOVERY_ADDRESS   | IP address for multicast<br>Specify this if you run multiple control-buses on the same network area. |
| AGENT_RESOURCE_PATH | Resource path | (OPTION) |

## Notificator
1. Get the latest [Notificator](https://github.com/job-streamer/job-streamer-notificator/releases/latest)

2. Run the notificator

        % bin/notificator [setting edn file path] [directory path where hbs files exist]

3. Environment settings

| Environment variable             | Description | Default value |
|:-----------------------------|:----|:----------|
| NOTIFICATOR_PORT             | Port number | 2121 |

> Please refet tr [notificator config](./notificator-config.html) about edn/hbs files.

## Deploy batch components
Please refer to [Deploy batch components](./deploy-batch-components.html).

## Set logger
Set environment variables, CONTROL_BUS_RESOURCE_PATH and AGENT_RESOURCE_PATH and place [logback.xml](https://logback.qos.ch/manual/configuration_ja.html) in there if you want to set logger.
