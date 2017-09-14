type=page
status=publish
~~~~~~

# Schedule job
You can control automatic job execution using calendar and cron expressions.

## How to register calendar
You can specify job execute date by creating a calendar and associating it with a job.

### 1. Select "Calendar" from the pull-down menu at the header right menu.
![image](img/goto-calendar.png)

### 2. Press "New" button on the calendar page.
![image](img/goto-calendar-new.png)

### 3. Input information and create calendar.
Enter calendar name, select dates and press "Save" button to create calendar.
If the business date you want to set does not start at 00:00 (For example, a case where you needs to consider Jun/2/2017 01:00 as Jun/1/2017 25:00), enter the start time of the day in "Day start".
![image](img/create-calendar.png)

### 4. Associate calendar with job.
It is necessary to associate a calendar to a job as following "How to register schedule" in order to use calendar actually.
You can prevent a job execution on dates which are not included in a calendar by setting calendar with cron expressions.

## How to register schedule
You can schedule a job execution by calendar and Quartz format (cron expressions).

### 1. Open the schedule edit view from the "Next" panel on the job detail page.
![image](img/schedule.png)

### 2. Easy creation of schedule.
You can construct a quartz format interactively on the "Next" panel.

#### 2.1. Select schedule pattern from Daily or Weekly, Monthly.

![image](img/select-pattern-of-schedule.png)

#### 2.2. Enter ignition time (hour).

![image](img/input-fire-time.png)

#### 2.3. Quartz format will be constructed and enterd in the form automatically.

![image](img/output-cron.png)

Finally, the value of the Quartz format form will be submitted.
If you want to enter the Quartz format directly, enter it in the [cron expressions](http://www.quartz-scheduler.org/documentation/quartz-2.x/tutorials/crontrigger.html) format.

![image](img/schedule_quartz.png)

### 3. Associate calendar
Associate a calendar that that you registered in the "How to register calendar" section with the schedule.

![image](img/schedule_calendar.png)

### 4. Register schedule
When you register the schedule by "Save" button, then automatic job execution starts.
It will fire at the date and time that match both its cron expression and its calendar.
