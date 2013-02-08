# Helper library for writing drains

require 'eventmachine'
require 'socket'

module Drain
  def self.run(&block)
    EM.run {
      q = EM::Queue.new
      EM.start_server '127.0.0.1', 9123, Handler, q
      puts "To let logyard connect to this drain, run (for example): "
      puts "    kato log drain add mytestdrain tcp://127.0.0.1:9123"

      # Read from the queue
      cb = Proc.new do |event|
        block.call(event)
        q.pop &cb
      end
      q.pop &cb
    }
  end

  private
  class Handler < EM::Connection
    include EM::Protocols::LineText2
    def initialize(q)
      @queue = q
    end
    def receive_line(line)
      @queue.push line
    end
  end

  private
  def self.get_local_ip
    # http://stackoverflow.com/a/7809304
    Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  end
  
end

