# Display cloud events as raw JSON
# Add using:
#   kato log drain add -p event -f json mytestdrain tcp://127.0.0.1:9123

require 'json'
require './drain'

Drain.run do |event|
  puts JSON.parse(event)
end
