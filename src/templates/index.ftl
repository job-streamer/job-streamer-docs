<#import "layout.ftl" as layout>
<@layout.myLayout>
  <header>
    <div class="ui one column centered grid">
      <div class="column">
        <h1>JobStreamer</h1>
        <img src="img/overview.png" class="original-size"/>
      </div>
    </div>
  </header>
  <section class="ui one column centered grid">
    <div class="column">
        <h2 class="ui header">Concept</h2>
        <p>
        JobStreamer is a distributed executing environment for JavaBatch jobs.<br/>
        It can execute jobs that do not conform to JavaBatch.<br/>
        <br/>
        Control bus is a control server of JobStreamer. It provides REST APIs and control all processes.<br/>
        Agent it a job execution agent in JobStreamer. At the moment you start the virtual image without any configuration or deploy, it will be a execution server. So you can scale out easily according to the loading amount.<br/>
        Management console is a front-end of JobStreamer. It has a function to call APIs on the Control-bus and display the result.<br/>
        </p>
    <div>
  </section>
</@layout.myLayout>
