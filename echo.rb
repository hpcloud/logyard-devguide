# Echo drain receives events from logyard as it receives them.

require 'eventmachine'

class EchoDrain < EM::Connection
  include EM::Protocols::LineText2
  
  def receive_line(line)
    puts line
  end
end

EM.run {
  EM.start_server '127.0.0.1', 9123, EchoDrain
  puts "To let logyard connect to this drain, run (for example): "
  puts "    kato log drain add mytestdrain tcp://127.0.0.1:9123"
}
