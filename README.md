# Logyard Cookbook

First clone this repo inside the Stackato VM and follow along the
instructions.

## The "echo" drain

The echo drain is the simplest drain of all.

```sh
$ ruby echo.rb 
To let logyard connect to this drain, run (for example): 
    kato log drain add mytestdrain tcp://127.0.0.1:9123
```

As instructed, tell logyard of your new drain:

```sh
kato log drain add mytestdrain tcp://127.0.0.1:9123
```

The above command will have all events from your cluster sent to the
echo drain, which in turn would print them as they come in.

## Our drain library

echo.rb contains a bit of eventmachine machinary and, as we'll be
basing other drains using similar mechanism, let's abstract this out
as a ruby module `drain.rb`. The echo drain can now be further simplified:

```ruby
# echo2.rb -- much simpler than echo.rb
EM.run {
  Drain.run do |event|
    puts event
  end
}
```

Writing a drain is as simple as that.
