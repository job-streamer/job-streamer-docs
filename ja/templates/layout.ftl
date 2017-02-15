<#macro myLayout>
<!DOCTYPE html>
<html lang="ja">
   <head>
      <meta charset="UTF-8"/>
      <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
      <meta name="viewport" content="width=device-width, initial-scale=1"/>
      <meta name="description" content="JobStreamer : JobStreamer site."/>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.1.8/semantic.min.css" type="text/css"/>
      <link rel="stylesheet" href="${content.rootpath}css/basic.css" type="text/css"/>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/prism/1.5.0/themes/prism.css" type="text/css"/>
   </head>
   <body>
         <div class="ui fixed inverted teal menu">
            <div class="title item"><a href="./index.html"><b>Job Streamer</b></a></div>
         </div>
         <div/>
         <div id="main_content_wrap" class="main ui grid content">
         <div class="four wide column">
            <#include "menu.ftl">
         </div>
         <div class="twelve wide stretched column">
            <#nested/>
         </div>
         </div>
         <div class="ui inverted teal footer vertical segment">
            <div class="container">
               <div class="ui stackable divided relaxed grid">
                  <div class="sixteen wide column">
                     <p>Copyright @ 2015-2016 kawasima &amp; contributors.</p>
                     <p>Released under the EPL license.</p>
                  </div>
               </div>
            </div>
         </div>
      <script src="https://cdn.jsdelivr.net/jquery/1.12.3/jquery.min.js"></script>
      <script src="https://cdn.jsdelivr.net/prism/1.5.0/prism.js"></script>
      <script src="https://cdn.jsdelivr.net/prism/1.5.0/components/prism-java.min.js"></script>
      <script src="https://cdn.jsdelivr.net/prism/1.5.0/components/prism-bash.min.js"></script>
      <script src="https://cdn.jsdelivr.net/prism/1.5.0/plugins/line-numbers/prism-line-numbers.min.js"></script>
      <script src="https://cdn.jsdelivr.net/semantic-ui/2.1.8/semantic.min.js"> </script>
   </body>
</html>
</#macro>