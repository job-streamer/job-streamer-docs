.. highlight:: guess

Quickly
===========

Control bus
--------------

1. Get datomic-free::

   % unzip datomic-free-0.9.5130.zip
   % cd datomic-free-0.9.5130
   % bin/transactor config/samples/free-transactor-template.properties

2. Download the latest version `control bus`_::

.. _control bus:        https://github.com/job-streamer/job-streamer-control-bus/releases

3. Run the contorl bus::

    % bin/control_bus
  default port 45102

Management console
-------------------

1. Download the latest version `management console`_::

.. _management console:        https://github.com/job-streamer/job-streamer-console/releases

2. Run the management console::

    % bin/console
  default port 8080

Agent
-------------------

1. Download the latest version `agent`_::

.. _agent:        https://github.com/job-streamer/job-streamer-agent/releases

2. Run the agent::

    % bin/agent
  default port 4510

Notificator
-------------------

1. Download the latest version `notificator`_::

.. _notificator:        https://github.com/job-streamer/job-streamer-notificator/releases

2. Run the notificator::

    % bin/notificator
  default port 2121
