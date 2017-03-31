type=page
status=publish
~~~~~~

# Getting Started for contributers
Developers of JobStreamer can develop it efficiently by using Clojure REPL.

## Start REPL
All components included in JobStreamer can be run and developped in the REPL.
You need install jdk and [Leiningen](https://leiningen.org/) to run REPL.

### Example: Control-bus

#### 1. Clone project

        % git clone https://github.com/job-streamer/job-streamer-control-bus.git

#### 2. Run REPL

        % cd job-streamer-control-bus
        % lein do clean, repl

The same applies to other components.

## Common commands
You can enter Clojre code directly to execute and improve efficiency of development with following commands.

### (dev)
Switch to the developer mode and activate following commands.

### (go)
Start system.

### (reset)
Reload setting and restart system.

### (test)
Run tests.