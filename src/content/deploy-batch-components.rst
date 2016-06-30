.. highlight:: guess

Deploy batch components
===========

How to deploy
--------------

You can deploy batch conpornent on control bus using `maven plugin`_ .

For the reason,we recommend you make batch conpornent as "maven project"

.. _maven plugin: https://github.com/job-streamer/job-streamer-maven-plugin

Example
--------------

1. Get Example::

   % git clone https://github.com/job-streamer/job-streamer-examples.git

2. Deploy it::

   % cd job-streamer-examples
   % mvn -e clean package job-streamer:deploy
  Deployed on control-bus.
  
  It needs that deploy resources and control bus are in same server.