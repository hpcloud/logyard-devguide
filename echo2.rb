# Rewrite of echo.rb using the drain helper library (drain.rb)

require './drain'

Drain.run do |event|
  puts event
end
