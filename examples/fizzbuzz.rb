$:.unshift File.expand_path '../../lib', __FILE__
require 'pry'
require 'pry-autopilot'

Pry.hooks.clear(:before_session)

my_pilot = PryAutopilot.new do

  on ->(f) {@i % 15 == 0} do
    puts "#{@i}:\tfizzbuzz"
  end

  on ->(f) {@i % 3 == 0} do
    puts "#{@i}:\tfizz"
  end

  on ->(f) {@i % 5 == 0} do
    puts "#{@i}:\tbuzz"
  end
end

# FIZ BUZZ
1.upto(100) do |i|
  my_pilot.frame.exec {@i = i}
  my_pilot.process_predicates
end
