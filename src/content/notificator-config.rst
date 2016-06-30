.. highlight:: guess
Notificator config
==============

Make rule using edn file.
Define action when some key is sent from control bus at edn file.
POST :messge key content to :uri key.

Ex. ::


  { :do-job {:uri "http://localhost:45102/default/job/job2/executions?Exchange.CONTENT_TYPE=application/edn"
             :message "{}"}
  }

This means that if ":do-job" key was sent to notificator, POST to "http://localhost:45102/default/job/success-mail/executions?Exchange.CONTENT_TYPE=application/edn".
So that "success-mail" job run.

*It needs that Control bus and Notificator are in same server.