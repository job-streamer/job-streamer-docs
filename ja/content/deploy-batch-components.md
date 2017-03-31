type=page
status=publish
~~~~~~

# バッチ部品のデプロイ

## デプロイ手法

[maven plugin](https://github.com/job-streamer/job-streamer-maven-plugin) を用いて、もしくは jar ファイルに固めた上で Console から、バッチ部品を Control-bus 上にデプロイします。
いずれの手段を用いるにしてもバッチ部品は maven プロジェクトで作成することを推奨します。

### maven plugin からデプロイを行う

例
==

#### 1. Example を取得:

        % git clone https://github.com/job-streamer/job-streamer-examples.git

#### 2. デプロイ:

        % cd job-streamer-examples
        % mvn -e clean package job-streamer:deploy

> job-streamer-examples/pom.xml に control-bus の認証情報を記述する必要があります。
> デプロイを行うにはデプロイ資源とcontrol-busが同じサーバーに存在する必要があります。

### Console からデプロイを行う

例
==

#### 1. Example を取得:

        % git clone https://github.com/job-streamer/job-streamer-examples.git

#### 2. with-dependencies.jar を作成

        % cd job-streamer-examples
        % mvn compile assembly:single

#### 3. 右メニューから「Upload Batch Components」に遷移
#### 4. 1. で作成した jar ファイルを「Drop files here to upload」と書かれた領域にドラッグアンドドロップし、アップロード
