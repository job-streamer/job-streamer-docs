<#import "layout.ftl" as layout>
<@layout.myLayout>
  <header>
    <div class="ui one column centered grid">
      <div class="column">
        <h1>JobStreamer</h1>
        <img src="img/overview.png"/>
      </div>
    </div>
  </header>
  <section class="ui one column centered grid">
    <div class="column">
        <h2 class="ui header">コンセプト</h2>
        <p>
        JobStreamerは、JavaBatchの分散実行環境です。設定やデプロイなしで実行環境をクラウド上に構築できるため、負荷量に応じて非常に簡単に実行環境を増減させることが出来ます。

        JavaBatchでは規格化されていないJobをスケジュール実行することも可能です。

        Agentはノーデプロイ、ノーコンフィギュレーション。仮想イメージを立ち上げると瞬時にジョブ実行サーバとなります。
        Management consoleはControl busのフロントエンドで、Control busの提供するAPIから取得した結果を表示する機能だけを持ちます。
        </p>
    <div>
  </section>

</@layout.myLayout>
