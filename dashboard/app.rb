require "fnordmetric"
require "./stackato.rb"

FnordMetric.namespace :Stackato do

  # render a timeseries graph
  widget 'Requests',
    :title => "Requests per Minute",
    :gauges => [:requests_per_minute],
    :type => :timeline,
    :width => 100,
    :autoupdate => 1

end

Stackato.run
