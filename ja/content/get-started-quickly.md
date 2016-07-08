type=page
status=publish
~~~~~~


# クイックスタート

## Control bus

1.  datomic-freeを取得:

        % unzip datomic-free-0.9.5130.zip
        % cd datomic-free-0.9.5130
        % bin/transactor config/samples/free-transactor-template.properties

2.  最新版 [control-bus](https://github.com/job-streamer/job-streamer-control-bus/releases)を取得:

3. contorl busを起動:

    % bin/control_bus

> デフォルトポート45102で起動します。

## Management console

1.  最新版 [management console](https://github.com/job-streamer/job-streamer-console/releases)
    を取得:

2. consoleを起動:

    % bin/console

> デフォルトポート8080で起動します。

## Agent

1.  最新版[agent](https://github.com/job-streamer/job-streamer-agent/releases)を取得:

2. agentを起動:

    % bin/agent

> デフォルトポート4510で起動します。

## Notificator

1.  最新版[notificator](https://github.com/job-streamer/job-streamer-notificator/releases)を取得:

2. notificatorを起動:

    % bin/notificator {ednファイルのパス}

> デフォルトポート2121で起動します。
> ednファイルについては[notificator config](./notificator-config.html)を参照してください。
