type=page
status=publish
~~~~~~

# Agent
Agent is an execution agent in JobStreamer.
It enable JobStreamer to parform distributed execution with no deploy and configuration.
All job executions in JobStreamer are performed by calling agent API from Control-bus.

## What Agent can do
Execution server does not need any deploy or any configuration except for running this Agent.
Agent connets to Control-bus at the morment the agent starts. And job execution get enabled.
Agent can be run as single java process or Docker container.

## GitHub
https://github.com/job-streamer/job-streamer-agent
