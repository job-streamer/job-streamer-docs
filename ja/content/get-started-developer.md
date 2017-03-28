type=page
status=publish
~~~~~~

# コントリビューター向けクイックスタート
JobStreamer の開発者は Clojure REPL を使うことで効率的に開発を進めることができます。

## REPL 起動
JobStreamer に含まれる全コンポーネントは REPL から起動し、開発することが出来ます。
REPL を起動するためには jdk, [Leiningen](https://leiningen.org/) が必要となるためインストールして下さい。

### 例: Control-bus の場合

#### 1. プロジェクトを clone

        % git clone https://github.com/job-streamer/job-streamer-control-bus.git

#### 2. REPL 起動

        % cd job-streamer-control-bus
        % lein do clean, repl

その他のコンポーネントに関しても同様です。

## 共通コマンド
REPL 上では Clojure のコードを直接入力して実行できる他、下記の共通コマンドによりコンポーネントの開発を効率化することが出来ます。

### (dev)
開発者モードに切り替えて、以下のコマンドを利用可能にする

### (go)
システム起動

### (reset)
設定をリロードしてシステム再起動

### (test)
テストの実行
