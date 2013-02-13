# Display app push requests
# Add using:
#   kato log drain add -p event -f json mytestdrain tcp://127.0.0.1:9123

require 'json'
require './drain'

puts "Listening for app push events..."
Drain.run do |event|
  event = JSON.parse(event)
  if event["Type"] == "stager_start"
    name = event["Info"]["app_name"]
    puts "Deploying application #{name}"
  elsif event["Type"] == "stager_end"
    name = event["Info"]["app_name"]
    puts "Finished deploying #{name}"
  end
end
