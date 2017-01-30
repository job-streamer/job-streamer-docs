type=page
status=publish
~~~~~~


# クイックスタート

## Control bus

1.  [datomic-free](https://my.datomic.com/downloads/free)を取得:

        % unzip datomic-free-0.9.5394.zip
        % cd datomic-free-0.9.5394
        % bin/transactor config/samples/free-transactor-template.properties

2.  最新版 [control-bus](https://github.com/job-streamer/job-streamer-control-bus/releases/latest)を取得:

3. contorl busを起動:

    % bin/control_bus

4. 環境設定

|    環境変数名      | 　　説明 　　 | デフォルト値    |
|:----------------:|:-----------:|:------------:|
| CONTROL_BUS_PORT |ポート番号      |     45102   |
|DISCOVERY_PORT|実行エージェントからの接続要求をLISTENするためのポート|45100|
|DISCOVERY_ADDRESS|実行エージェントからの接続要求をLISTENするためのマルチキャストIP|(OPTION)|
|NOTIFICATOR_URL|通知サーバのURL|http://localhost:2121|
|ACCESS_CONTROL_ALLOW_ORIGIN|オペレーターからみたconsoleのURL|http://localhost:3000
|CONTROLE_BUS_RESOURCE_PATH|control-busのクラスパスに追加されるパス|(OPTION)


## Management console

1.  最新版 [management console](https://github.com/job-streamer/job-streamer-console/releases/latest)
    を取得:

2. consoleを起動:

    % bin/console

3. 環境設定

|    環境変数名      | 　　説明 　　 | デフォルト値    |
|:----------------:|:-----------:|:------------:|
| CONSOLE_PORT     |ポート番号      |     3000   |
| CONTROL_BUS_URL  |Control-busのurl | http://localhost:45102     |

## Agent

1.  最新版[agent](https://github.com/job-streamer/job-streamer-agent/releases/latest)を取得:

2. agentを起動:

    % bin/agent

3. 環境設定

|    環境変数名      | 　　説明 　　 | デフォルト値    |
|:----------------:|:-----------:|:------------:|
| AGENT_PORT       |ポート番号      |     4510   |
| INSTANCE_NAME    | インスタンス名<br> 起動ごとにAgentのIDが変えたくない場合はこれを指定してください。|  (OPTION)  |
|DISCOVERY_PORT|接続要求をブロードキャスト(またはマルチキャスト)するためのポート|45100|
|DISCOVERY_ADDRESS|接続要求をマルチキャストするためのIPアドレス。<br>同一ネットワーク内に複数のコントロールバスを起動する場合はこれを指定して下さい。|(OPTION)|
|AGENT_RESOURCE_PATH|agentのクラスパスに追加されるパス|(OPTION)

## Notificator

1.  最新版[notificator](https://github.com/job-streamer/job-streamer-notificator/releases/latest)を取得:

2. notificatorを起動:

    % bin/notificator {ednファイルのパス} (hbsファイルのあるディレクトリのパス)

3. 環境設定

|    環境変数名      | 　　説明 　　 | デフォルト値    |
|:----------------:|:-----------:|:------------:|
| NOTIFICATOR_PORT |ポート番号      |     2121   |
| NOTIFICATOR_RULES|ルール(edn)ファイルのパス| （第一引数） |
| NOTIFICATOR_TEMPLATES_PLEFIX|テンプレート(hbs)のあるディレクトリのパス|templates|

> edn/hbsファイルについては[notificator config](./notificator-config.html)を参照してください。

## バッチ部品のデプロイ
[バッチ部品のデプロイ](./deploy-batch-components.html)を参照してください。

## ログの取得
環境変数CONTROL_BUS_RESOURCE_PATH, AGENT_RESOURCE_PATHを設定し、そこに[logback.xml](https://logback.qos.ch/manual/configuration_ja.html)を配置することでlogの定義を独自定義することが可能です。