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
        <h2 class="ui header">Concept</h2>
        <p>
        JobStreamer is a distributed executing environment for jobs. 
        JobStreamer can execute job that is not on the rule of JavaBatch.

        Agent that executes jobs has an exclusive feature. It's No deploy and No configuration.
        Management console is front-end of Control bus. It has a function only desplay result got from Control bus API.
        </p>
    <div>
  </section>

</@layout.myLayout>
