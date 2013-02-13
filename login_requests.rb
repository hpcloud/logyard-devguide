# Display user login requests by parsing the cloud_controller log
# Add using:
#   kato log drain add -f json mytestdrain tcp://127.0.0.1:9123

require 'json'
require './drain'

puts "Listening for login events..."
Drain.run do |event|
  event = JSON.parse(event)
  # We are looking for JSON like:
  # {"Name":"cloud_controller","NodeID":"172.16.145.208","Text":"[2013-02-13 12:14:40.036353] cc - pid=18495 tid=3209 fid=5e01  DEBUG -- Legacy login request from s@s.com","UnixTime":1360786480}
  if event["Name"] == "cloud_controller"
    if event["Text"] =~ /.*DEBUG -- Legacy login request from (.+)$/
      puts "#{Time.now} => #{$1} just logged in"
    end
  end
end
