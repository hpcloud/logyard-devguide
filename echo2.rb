# Rewrite of echo.rb using the drain helper library (drain.rb)

require 'eventmachine'
require './drain'

EM.run {
  Drain.run do |event|
    puts event
  end
}
