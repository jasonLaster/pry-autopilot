# pry-autopilot.rb

require "pry-autopilot/version"
require "pry-autopilot/frame"
require "pry-autopilot/input"

class PryAutopilot
  attr_accessor :input
  attr_reader :predicates
  attr_accessor :_pry_
  attr_accessor :frame

  def initialize(fallback_input=Readline, &block)
    @input = Input.new(self)
    @fallback_input = fallback_input
    @frame = Frame.new(binding)
    instance_exec(&block) if block
  end

  def readline(prompt)
    process_predicates if input.empty?
    input.shift || fallback_readline(prompt)
  end

  def on(predicate, &block)
    @predicates ||= []
    @predicates << [predicate, block]
  end

  def fallback_readline(prompt)
    if @fallback_input.method(:readline).arity == 0
      @fallback_input.readline
    else
      @fallback_input.readline(prompt)
    end
  end

  def process_predicates
    return if !predicates
    predicates.each do |predicate, block|
      if frame.exec &predicate
        frame.exec &block
      end
    end
  end
end
