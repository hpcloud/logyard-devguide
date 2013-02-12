# Display app push requests

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
