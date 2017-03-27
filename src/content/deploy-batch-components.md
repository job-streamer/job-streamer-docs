type=page
status=publish
~~~~~~


#Deploy batch components

## How to deploy

You can deploy batch conpornent on control bus using [maven plugin](https://github.com/job-streamer/job-streamer-maven-plugin) .

For the reason, we recommend you make batch component as "maven project"

## Example

1.  Get Example:

        % git clone https://github.com/job-streamer/job-streamer-examples.git

2. Deploy it:

        % cd job-streamer-examples
        % mvn -e clean package job-streamer:deploy

> Deployed on control-bus.
> It needs that deploy resources and control bus are in same server.
