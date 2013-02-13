require "fnordmetric"

if redis_url = ENV["REDIS_URL"]
  FnordMetric::DEFAULT_OPTIONS[:redis_url] = redis_url
end

module Stackato

  def self.run
    Stackato.standalone_custom ENV["PORT"] || 5000
  end

  # delineating
  # <https://github.com/paulasmuth/fnordmetric/blob/master/fnordmetric-core/lib/fnordmetric/standalone.rb>
  # to specify custom PORT.
  private
  def self.standalone_custom(port)
    FnordMetric::Web.new(:host => "0.0.0.0", :port => port)
    FnordMetric::Worker.new
    FnordMetric.start_em
  end

end
