type=page
status=publish
~~~~~~

# Create job

## 1. Open the login page of job-streamer-console.
http\://[IP address of the server]:[port number of Console(default: 8080)]

## 2. Enter id/password of the login user and login.
Built-in admin user is admin/password123

## 3. Press the "New" button on the top page.

![image](img/new_job_button.png)

## 4. Create a job.
For example, we create a simple job that has only one step as following.

![image](img/make-step.png)
![image](img/make-batchlet.png)
![image](img/select-batchlet-ref.png)
![image](img/type-job-name.png)

* Set attributes.
![image](img/set-attr.png)
* Set properties.
    * You can specify a job parameter here in the following format (EL: Expression Language).
        \#{jobParameters['ParameterName']}

![image](img/set-properties.png)

You can use only batch components (Batchlet/ItemReader/ItemWriter/ItemProcessor etc.) that was deployed to the Control-bus.
If you want to use new batch components, please refer to [Deploy batch components](./deploy-batch-components.html).
