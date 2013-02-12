# Display cloud events as raw JSON

require 'json'
require './drain'

Drain.run do |event|
  puts JSON.parse(event)
end
