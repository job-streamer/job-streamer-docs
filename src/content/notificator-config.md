type=page
status=publish
~~~~~~

# Notificator config
Please refer to [Notificator](./notificator.html) about the Notificator.

## Setting file
Setting file have to be edn format.
It defines the behavior when a certain key is sent from the Control-bus.
This setting will be reflected when this file is specified as the first argument of the Notificator (To be described later).

### Ex1: Send a job success mail.

    {
      :send-success-email {:uri "http://localhost:45102/default/job/success-mail/executions?Exchange.CONTENT_TYPE=application/edn"}
    }

In this setting, the Notificator executes a job named "success-mail" by sending a POST request to "http\://localhost:45102/default/job/success-mail/executions?Exchange.CONTENT\_TYPE=application/edn" when Notificator receives :send-success-email key from the Control-bus.
A job named "success-mail" needs to be made to send a success mail.

### Ex2: Send a job success mail by requesting to a smtp server.

    {
      :send-success-email {
        :uri "smtp://[smtp-server-ip-address]:25?from=example-from@example.com&to=example-to@example.com&subject=success"
        :message "success"
      }
    }

In this setting, the Notificator sends a request directly to the smtp server when Notificator receives :send-success-email key from the Control-bus.

### Setting edn file format
Describe setting file in the following format.

    {:key1 {:uri     "xxx"
            :to      "yyy"
            :message "zzz"}
     :key2 {...}
     ...
     :keyx{...}}

* :uri - Describe the behavior when the Notificator receive a key.
    * It is equivalent to Apache Camel's RouteBuilder#from.
    * Please refer to [http://camel.apache.org/components.html](http://camel.apache.org/components.html) about behaviors you can set.
* :to  - It is equivalent to Apache Camel's RouteBuilder#to.
* :message - It is equivalent to Apache Camel's setBody.

## Use Handlebars (template function)
You can create templates such as mail bodies by using the Handlebars.
For example, create a hbs file (success.hbs) like the following.

    Hello, your batch is {{exit-status}}!
    end time is {{end-time}}

You can specify following keys in the hbs file.

|Key name|Description|
|-----|---|
|job-name|job name|
|start-time|start date time|
|end-time|finish date time|
|batch-status|batch status|
|exit-status|exit status|

And specify hbs file name (without extension) with "message-template" key.

    {
      :send-success-email {
        :uri "smtp://[smtp-server-ip-address]:25?from=example-from@example.com&to=example-to@example.com&subject=success"
        :message-template "success"
      }
    }

Then a mail with the following body will be sent when the Notificator receives ":send-success-email" key.

    Hello, your batch is COMPLETED!end time is Sat Sep 17 01:09:29 JST 2016

## Start Notificator
Start like the following.

    bin/notificator [edn file] [hbs file dir]

If you use multiple hbs files, put then in the same directory (hbs file dir).
You can omit the second argument if you do not use the hbs file.
