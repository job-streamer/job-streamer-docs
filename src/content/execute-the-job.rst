.. highlight:: guess
Execute a job
===========

Manual execution
--------------
Push play button at job list view(top page),then you can manually execute.

Forcibly stop execution
--------------
Push stop button at job list view(top page),then you can stop job execution.

Restart
--------------
If you made job be able to restart,you can restart falure/abandoned job.

.. image:: _images/restart.png
 :width: 100%

If parameter is needed, Jobstreamer automatically analize and make input form,then you input value and push restart button

.. image:: _images/restart_dialog.png
 :width: 100%

scheduled execution
--------------
You can automatically execute job registrationing schedule using `quartz scheduler`_ .

.. _quartz scheduler: http://quartz-scheduler.org/api/2.2.0/org/quartz/CronExpression.html

.. image:: _images/schedule_quartz.png
 :width: 100%

Set calendar
--------------
You can control job execution setting calendar with quartz scheduler.