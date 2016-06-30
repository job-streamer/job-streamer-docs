
JobStreamer developer guide
========================================

----------------------------------------
Format policy
----------------------------------------

* All of exchange data is done using `EDN Format`_ .（In comparison with the JSON, there is an advantage that it is possible to have a type of ``Date`` and ``UUID`` . ）
* Map key in EDN is keyword with entity's name-space. (Easy to understand when see only data.)

----------------------------------------
Interface policy
----------------------------------------

* Both Agent and Control bus use REST API as interface.（for enable tool-development Other than Console）
* Must call from Control bus to Agent API.Don't call reverse. 

----------------------------------------
connection policy
----------------------------------------

* In order to Improve responsivility of Agent,WebSocket connect bus from agent  to Control.
* Consideration of failure,WebSocket doesn't exchange data,only notification.
* Monitoring dead-or-alive and performance of Agent is done through WebSocket. 
* In order to make Agent be no configuration,detect Control bus address automatically.

  #. Agent broadcast its own address when process starts.
  #. When Control bus catch broadcast from Agent, send connection request to Agent.
  #. Agent that recieve connection request try to connect control bus on WebSocket.

* When close connection from Agent to Control bus,Agent restart broadcast,so that even if switch Control bus stand-by,switch connection automatically.

----------------------------------------
Persitence policy
----------------------------------------

* All data flowing at Control bus are stored in Datomic.
* Accessing to Datomic is allowed only from Control bus.

----------------------------------------
If you want more safely structure
----------------------------------------

* Because `WebSocketClassLoader`_ is eccentric structure,enable useing application deploying to Agent. 
  In this case,If bypass ClassLoder configuation,Agent's local context ClassLoder is used.
  In this way,enable to use JobStreamer as job scheduler.
* Job's execution log is sent to Control bus and stored in Datomic in the default setting.
* Depending on logback setting, be able to write log into local file of Agent or Control bus. 

.. _EDN Format: https://github.com/edn-format/edn
.. _WebSocketClassLoader: https://github.com/kawasima/websocket-classloader