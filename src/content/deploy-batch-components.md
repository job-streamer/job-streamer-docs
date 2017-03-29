type=page
status=publish
~~~~~~

# Deploy batch components

## How to deploy
You can deploy batch conpornents on Control-bus using [maven plugin](https://github.com/job-streamer/job-streamer-maven-plugin) or by upload a jar file that has all dependencies of components in it to Console.
Anyway, we recommend that you make a batch components project as a "maven project".

### Deploy using [maven plugin](https://github.com/job-streamer/job-streamer-maven-plugin)

Example
==

#### 1. Get example:

        % git clone https://github.com/job-streamer/job-streamer-examples.git

#### 2. Deploy:

        % cd job-streamer-examples
        % mvn -e clean package job-streamer:deploy

> It is necessary to write authentication information for Control-bus on pom.xml.
> It is necessary that deploy resources and Control-bus exist in the same server.

### Delopy from Console

Example
==

#### 1. Get example:

        % git clone https://github.com/job-streamer/job-streamer-examples.git

#### 2. Create with-dependencies.jar:

        % cd job-streamer-examples
        % mvn compile assembly:single

#### 3. Transit to "Upload Batch Components" in the header right menu:
#### 4. Drag and drop the jar file created in step 1 to "Drop files here to upload" area, and the jar file will be upoloaded:
