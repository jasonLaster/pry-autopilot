class PryAutopilot
  class Frame
    def initialize(binding)
      @binding = binding
    end

    def method_name
      @binding.eval("__method__").to_sym
    end

    def class_name
      @binding.eval("self.class.name").to_sym
    end

    def self
      @binding.eval("self")
    end

    def eval(*args)
      @binding.instance_eval(*args)
    end
    alias var eval

    def exec(&block)
      @binding.instance_eval &block
    end

  end
end
