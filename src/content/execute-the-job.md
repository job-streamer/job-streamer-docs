type=page
status=publish
~~~~~~

# Execute a job

## Manual execution
Push play button at job list view(top page),then you can manually execute.

## Forcibly stop execution
Push stop button at job list view(top page),then you can stop job execution.

## Restart
If you made job be able to restart,you can restart falure/abandoned job.

![image](img/restart.png)


If parameter is needed, Jobstreamer automatically analize and make input form,then you input value and push restart button

![image](img/restart_dialog.png)

## scheduled execution

You can automatically execute job registrationing schedule using [quartz scheduler](http://quartz-scheduler.org/api/2.2.0/org/quartz/CronExpression.html)
.

![image](img/schedule_quartz.png)

## Set calendar

You can control job execution setting calendar with quartz scheduler.
