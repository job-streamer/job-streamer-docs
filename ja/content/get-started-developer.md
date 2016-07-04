# 開発者向け

## Control bus

1.  datomic-freeを取得:

        % unzip datomic-free-0.9.5130.zip
        % cd datomic-free-0.9.5130
        % bin/transactor config/samples/free-transactor-template.properties

2.  control busを取得:

        % git clone https://github.com/job-streamer/job-streamer-control-bus.git

3.  contorl busを起動:

        % lein run

## Management console

1.  management consoleを取得:

        % git clone http://github.com/job-streamer/job-streamer-console.git

2.  consoleを起動:

        % lein ring server

## Agent

1.  agentを取得:

        % git clone http://github.com/job-streamer/job-streamer-agent.git

2.  docker imageをビルド:

        % docker build -t job-streamer/agent:0.1.0

3.  docker containerを起動:

        % docker run job-streamer/agent:0.1.0

4.  コンテナは正常に起動すると、自動的にコントロールバスにコンタクトを取ります。
