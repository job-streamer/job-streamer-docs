type=page
status=publish
~~~~~~


# JobStreamer ディベロッパーガイド

## フォーマットの方針

-   データのやり取りは全て [EDN Format](https://github.com/edn-format/edn)で行う。（JSONと比較して、 `Date` や `UUID`の型を持つことができるというメリットがある。）
-   EDN中で用いるMapのキーは、エンティティのネームスペース付きのキーワードとする。（データだけを見た時に、そのほうが分かりやすいため。）

## インターフェースの方針

-   Agent, Control busともにREST APIをインターフェースとして用いる。（コンソール以外でツール開発を可能とするため。）
-   必ずControl-busからAgentのAPIを呼び出すこととする。逆向きの呼び出しは発生させない。

## 接続の方針

-   Agentの応答性を上げるため、AgentからControl-busへはWebSocket接続する。
-   障害時の動作を考慮し、WebSocketではデータの転送は行わず、通知のみとする。
-   Agentの死活や性能モニタリングは、WebSocketを通じて行われる。
-   Agentはノーコンフィギュレーションにするため、Control-busのアドレスを自動的に見つける。
    1.  Agentが起動したら自身のアドレスをブロードキャストする。
    2.  Control-busはAgentからのブロードキャストをキャッチしたら、接続のリクエストをAgentに送る。
    3.  Control-busへの接続リクエストを受けたAgentは、Control-busに対してWebSocket接続を試みる。
-   AgentからControl-busへの接続が切れると、Agentはブロードキャストを再開するようになるので、Control-busをスタンバイ機に切り替えても自動的に接続し直される。

## 永続化の方針

-   Control busに流れている情報は全てDatomicに格納する。
-   DatomicへのアクセスはControl busのみ許可する。

## 手堅い感じにする

-   [WebSocketClassLoader](https://github.com/kawasima/websocket-classloader)はエキセントリックな仕組みなので、Agentにアプリケーションをデプロイして使うことも可能にする。
    この場合、AgentでのClassLoaderの設定をバイパスしてやればAgentローカルのコンテキストクラスローダが使われる。
    こうすると、JobStreamerをただのジョブスケジューラとして使うことができる。
-   ジョブの実行ログはデフォルトでWebSocket経由でリアルタイムにControl-busに送信されて、Datomicに格納される。
-   logbackの設定次第で、Agentローカルのファイルにも書き込んだり、Control-busのローカルファイルに書き込んだりすることも可能である。
