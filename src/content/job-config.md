type=page
status=publish
~~~~~~

# Job config
## Exclusive execution
There are cases where it is incovenient for a job to be executed simultaneously.
In order not to be execute a job simultaneously, 
turn on "Exclusive execution" in the "Schedule settings" panel of the "Settings" tab of the job details page.
\# Notice that if you turn on this setting, multiple executions will not be fired even if they are scheduled.
\# A function, that dispatch a job again as soon as previous job is over, has not been implemented.

## Monitor job execution
You can configure job execution monitoring in the "Settings" tab.

![image](img/notificator_dojob.png)

### 1. Send mail according to batch status or exit status.
Set this in the "Notification" panel.
If you monitor batch status, select the batch status used for condition from the pull-down.
If you monitor exit status, enter the exit status used for condition.
Enter the notification key set in the notification server in the "Notification".

### 2. Send mail if a job is being executed for more than a certain period of time.
Set this in the "Schedule settings" panel.
Enter "a certain period of time" in the "Execution constraints" form, and select "Alert" in the pull-down.
Enter the notification key set in the notification server in the "Notification".

### 3. Stop job if it is being executed for more than a certain period of time.
Set this in the "Schedule settings" panel.
Enter "a certain period of time" in the "Execution constraints" form, and select "Stop" in the pull-down.
Target job needs to be restartable (it means all batchlets making up the job implement javax.batch.api.AbstractBatchlet.stop).

## About notification server
Please refer to [Notificator config](./notificator-config.html) for details.
