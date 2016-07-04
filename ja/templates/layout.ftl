<#macro myLayout>
<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset=utf-8"/>
      <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
      <meta name="viewport" content="width=device-width, initial-scale=1"/>
      <meta name="description" content="JobStreamer : JobStreamer site.">
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.1.8/semantic.min.css" type="text/css"/>
      <link rel="stylesheet" href="${content.rootpath}css/basic.css" type="text/css"/>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/prism/1.5.0/themes/prism.css" type="text/css"/>
   </head>
   <body>
      <#include "menu.ftl">
      <div class="pusher">
         <div class="ui fixed inverted teal menu">
            <div class="title item"><b>Job Streamer</b></div>
            <a class="view-ui item" onClick="viewSidebar()">
              Menu
            </a>
         </div>
         <div id="main_content_wrap" class="main grid content full height">
            <#nested/>
         </div>
         <div class="ui inverted teal footer vertical segment">
            <div class="container">
               <div class="ui stackable divided relaxed grid">
                  <div class="sixteen wide column">
                     <p>Copyright © 2015-2016 kawasima &amp; contributors.</p>
                     <p>Released under the EPL license.</p>
                  </div>
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
      <script type="text/javascript">
         function viewSidebar() {
           $('.sidebar')
             .sidebar('toggle');
         }
      </script>
   </body>
</html>
</#macro>