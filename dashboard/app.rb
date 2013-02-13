require "fnordmetric"

# TODO: cleanup
if redis_url = ENV["REDIS_URL"]
  puts "Using redis #{redis_url}"
  FnordMetric::DEFAULT_OPTIONS[:redis_url] = redis_url
  FnordMetric.options[:redis_url] = redis_url
end

FnordMetric.namespace :stackato do

  # render a timeseries graph
  widget 'Requests',
    :title => "Requests per Minute",
    :gauges => [:requests_per_minute],
    :type => :timeline,
    :width => 100,
    :autoupdate => 1

end


FnordMetric::Web.new(:host => "0.0.0.0",
                     :port => ENV["PORT"] || 5000)
FnordMetric.run

# FnordMetric.standalone
