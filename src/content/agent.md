type=page
status=publish
~~~~~~

# Agent
Agent is an execution agent in JobStreamer.
It enables JobStreamer to perform distributed execution with no deploy and configuration.
All job executions in JobStreamer are performed by calling agent API from Control-bus.

## What Agent can do
Execution server does not need any deploy nor any configuration except for running this Agent.
Agent connects to Control-bus at the moment the agent starts. And job execution get enabled.
Agent can run as a single java process or a Docker container.

## GitHub
https://github.com/job-streamer/job-streamer-agent
