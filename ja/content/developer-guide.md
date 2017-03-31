type=page
status=publish
~~~~~~

# コントリビューター向けガイドライン

## フォーマットの方針

-   データのやり取りは全て [EDN Format](https://github.com/edn-format/edn) で行う。（JSONと比較して、 `Date` や `UUID` の型を持つことができるというメリットがある。）
-   EDN 中で用いる Map のキーは、エンティティのネームスペース付きのキーワードとする。（データだけを見た時に、そのほうが分かりやすいため。）

## インターフェースの方針

-   Agent, Control-busともに REST API をインターフェースとして用いる。（コンソール以外でツール開発を可能とするため。）
-   必ず Control-bus から Agent の API を呼び出すこととする。逆向きの呼び出しは発生させない。

## 接続の方針

-   Agent の応答性を上げるため、 Agent から Control-bus へは WebSocket 接続する。
-   障害時の動作を考慮し、 WebSocket ではデータの転送は行わず、通知のみとする。
-   Agent の死活や性能モニタリングは、 WebSocket を通じて行われる。
-   Agent はノーコンフィギュレーションにするため、 Control-bus のアドレスを自動的に見つける。
    1.  Agent が起動したら自身のアドレスをブロードキャストする。
    2.  Control-bus は Agent からのブロードキャストをキャッチしたら、接続のリクエストを Agent に送る。
    3.  Control-bus への接続リクエストを受けた Agent は、 Control-bus に対して WebSocket 接続を試みる。
-   Agent から Control-bus への接続が切れると、 Agent はブロードキャストを再開するようになるので、 Control-bus をスタンバイ機に切り替えても自動的に接続し直される。

## 永続化の方針

-   Control-bus に流れている情報は全て Datomic に格納する。
-   Datomic へのアクセスは Control-bus のみ許可する。

## 手堅い感じにする

-   [WebSocketClassLoader](https://github.com/kawasima/websocket-classloader) はエキセントリックな仕組みなので、 Agent にアプリケーションをデプロイして使うことも可能にする。
    この場合、 Agent での ClassLoader の設定をバイパスしてやれば Agent ローカルのコンテキストクラスローダが使われる。
    こうすると、 JobStreamer をただのジョブスケジューラとして使うことができる。
-   ジョブの実行ログはデフォルトで WebSocket 経由でリアルタイムに Control-bus に送信されて、 Datomic に格納される。
-   logback の設定次第で、 Agent ローカルのファイルにも書き込んだり、 Control-bus のローカルファイルに書き込んだりすることも可能である。
