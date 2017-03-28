type=page
status=publish
~~~~~~

# Agent
## Agent とは？
Agent は JobStreamer におけるジョブの実行エージェントであり、ノーデプロイ、ノーコンフィギュレーションな分散実行を可能にするための仕組みです。
JobStreamer における job 実行はすべて Control-bus から Agent の API を呼び出すことで行います。

## Agentでできること
実行サーバにはこの実行エージェントを起動すること以外にデプロイ、設定は不要であり、エージェントを起動した瞬間に Control-bus と接続してジョブ実行が可能となります。
Agent は単体の Java プロセスとして起動する他、 Docker コンテナとして起動することもできます。

## GitHub
https://github.com/job-streamer/job-streamer-agent