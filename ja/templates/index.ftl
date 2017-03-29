<#import "layout.ftl" as layout>
<@layout.myLayout>
  <header>
    <div class="ui one column centered grid">
      <div class="column">
        <h1>JobStreamer</h1>
        <img class="original-size" src="img/overview.png"/>
      </div>
    </div>
  </header>
  <section class="ui one column centered grid">
    <div class="column">
        <h2 class="ui header">コンセプト</h2>
        <p>
        JobStreamer は JavaBatch の分散実行環境です。JavaBatch に規格化されていない Job をスケジュール実行することも可能です。<br/>
        <br/>
        Control bus は JobStreamer の制御サーバです。 REST API を提供し、全ての処理を制御します。<br/>
        Agent は JobStreamer の専用実行エージェントです。設定やデプロイなしで仮想イメージを立ち上げた瞬間にジョブ実行サーバとなるため、負荷量に応じて増減させることが簡単に出来ます。<br/>
        Management Console は JobStreamer のフロントエンドであり、 Control bus 上の処理を呼び出したり取得結果を表示する機能を持ちます。<br/>
        </p>
    <div>
  </section>

</@layout.myLayout>
