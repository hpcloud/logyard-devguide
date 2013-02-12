# Logyard Cookbook

First clone this repo inside the Stackato VM and follow along the
instructions.

## The "echo" drain

The echo drain is the simplest drain of all.

```
$ ruby echo.rb 
To let logyard connect to this drain, run (for example): 
    kato log drain add mytestdrain tcp://127.0.0.1:9123
```

As instructed, tell logyard of your new drain:

```
kato log drain add mytestdrain tcp://127.0.0.1:9123
```

The above command will have all events from your cluster sent to the
echo drain, which in turn would print them as they come in. You can
verify this by pushing an application by side.

## Our drain library

echo.rb contains a bit of eventmachine machinery and, as we'll be
basing other drains using similar mechanism, let's abstract this out
as a ruby module `drain.rb`. The echo drain can now be further simplified:

```ruby
# echo2.rb -- much simpler than echo.rb
Drain.run do |event|
  puts event
end
```

Writing a drain is as simple as that. Take a look at drain.rb and
echo2.rb if you're curious, but for now - it will be sufficient to
remember that the above 3 lines of code -- or 1 line, depending on how
you view it -- is all you need in order to write logyard drains in
ruby.

## Processing cloud events

Stackato's cloud events is a stream of key events from across the
Stackato cluster. Each event is represented in JSON format. The script
`events.rb` parses the JSON record and prints it for every received
event.

To setup a drain to receive only cloud events (`-p event`) and in JSON
format (`-f json`), run the following command after running events.rb:

```sh
kato log drain add -p event -f json mytestdrain tcp://127.0.0.1:9123
```

Once the drain is setup, deploy an arbitrary app to the cluster.
events.rb will receive events pertaining to that app's deployment and
print them as it is; for instance:

```
$ ruby events.rb
[...]
{"Type"=>"dea_stop", "Desc"=>"Stopping application 'env' on DEA d4879e", "Severity"=>"INFO", "Info"=>{"app_id"=>1, "app_name"=>"env", "dea_id"=>"d4879e", "instance"=>0}, "Process"=>"dea", "UnixTime"=>1360695004, "NodeID"=>"172.16.145.207"}
{"Type"=>"stager_start", "Desc"=>"Staging application 'env'", "Severity"=>"INFO", "Info"=>{"app_id"=>1, "app_name"=>"env"}, "Process"=>"stager", "UnixTime"=>1360695005, "NodeID"=>"172.16.145.207"}
{"Type"=>"stager_end", "Desc"=>"Completed staging application 'env'", "Severity"=>"INFO", "Info"=>{"app_id"=>1, "app_name"=>"env"}, "Process"=>"stager", "UnixTime"=>1360695009, "NodeID"=>"172.16.145.207"}
{"Type"=>"dea_start", "Desc"=>"Starting application 'env' on DEA d4879e", "Severity"=>"INFO", "Info"=>{"app_id"=>1, "app_name"=>"env", "dea_id"=>"d4879e", "instance"=>0}, "Process"=>"dea", "UnixTime"=>1360695009, "NodeID"=>"172.16.145.207"}
```

You will notice that all events JSON record have the following keys:
`Type, Desc, Severity, Info, Process, UnixTime, NodeID` -- they should
be self-explanatory. A custom drain may choose to filter events based
on one or more of these fields and then send them in turn to a
different service.
