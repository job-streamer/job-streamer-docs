type=page
status=publish
~~~~~~


# Getting Started

##Control bus

1.  Get datomic-free:

        % unzip datomic-free-0.9.5130.zip
        % cd datomic-free-0.9.5130
        % bin/transactor config/samples/free-transactor-template.properties

2.  Download the latest version [control bus](https://github.com/job-streamer/job-streamer-control-bus/releases):

3. Run the contorl bus:

        % bin/control_bus

4. Optional embiron setting

|Environment variable|Description|Default       |
|:----------------:|:-----------:|:------------:|
| CONTROL_BUS_PORT |Port Number  |     45102    |
|DISCOVERY_PORT|listen port from Agent|45100|
|DISCOVERY_ADDRESS|Multicast IP to listen from Agent|(OPTION)|
|NOTIFICATOR_URL|Notificator's url|http://localhost:2121|

## Management console

1.  Download the latest version [management console](https://github.com/job-streamer/job-streamer-console/releases):

2. Run the management console:

       % bin/console

3. Optional embiron setting

|Environment variable|Description|Default       |
|:----------------:|:-----------:|:------------:|
| CONSOLE_PORT     |Port Number  |     3000     |
| CONTROL_BUS_URL  |Control-bus's url |    http://localhost:45102     |

## Agent

1.  Download the latest version [agent](https://github.com/job-streamer/job-streamer-agent/releases):

2. Run the agent:

       % bin/agent

3. Optional embiron setting

|Environment variable|Description|Default       |
|:----------------:|:-----------:|:------------:|
| AGENT_PORT       |Port Number  |     4510     |
| INSTANCE_NAME    |instance name| (OPTION) |
|DISCOVERY_PORT|Port for Multicast|45100|
|DISCOVERY_ADDRESS|IP address for Multicast<br>If you run more than 2 control-bus,youmust set this. |(OPTION)|

## Notificator

1.  Download the latest version [notificator](https://github.com/job-streamer/job-streamer-notificator/releases):

2. Run the notificator:

       % bin/notificator {edn file path} (hbs dir path)

3. Optional embiron setting

|Environment variable|Description|Default       |
|:----------------:|:-----------:|:------------:|
| NOTIFICATOR_PORT |Port Number  |     2121   |
| NOTIFICATOR_RULES|edn file path| [first arg] |
| NOTIFICATOR_TEMPLATES_PLEFIX|template dir path|"templates"|

> please refer [notificator config](./notificator-config.html) about edn and hbs file.

## batch component deployment
please refer to [deploy batch components](./deploy-batch-components.html).
