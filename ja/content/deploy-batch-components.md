type=page
status=publish
~~~~~~

# バッチ部品のデプロイ

## デプロイ手法

[maven plugin](https://github.com/job-streamer/job-streamer-maven-plugin)を用いてバッチ部品をコントロールバス上にデプロイします。
そのため、バッチ部品はmavenプロジェクトで作成することを推奨します。

例
==

1.  Exampleを取得:

        % git clone https://github.com/job-streamer/job-streamer-examples.git

2.  デプロイ:

        % cd job-streamer-examples
        % mvn -e clean package job-streamer:deploy

> デプロイを行うにはデプロイ資源とcontrol-busが同じサーバーに存在する必要があります。

## Consoleからデプロイを行う

1. with-dependencies.jarを作成する

        % mvn compile assembly:single
        
2. 右メニューから「Upload Batch Components」に遷移
3. ドラッグアンドドロップで1.で作成したjarをアップロードする