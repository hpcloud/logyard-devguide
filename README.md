# Logyard Cookbook

First clone this repo inside the Stackato VM and follow along the
instructions.

## The "echo" drain

The echo drain is the simplest drain.

```bash
$ ruby echo.rb 
To let logyard connect to this drain, run (for example): 
    kato log drain add mytestdrain tcp://127.0.0.1:9123
```

As instructed, tell logyard of your new drain:

```bash
kato log drain add mytestdrain tcp://127.0.0.1:9123
```

The above command will have events from your cluster sent to the echo
drain, which in turn would print them as they come in.