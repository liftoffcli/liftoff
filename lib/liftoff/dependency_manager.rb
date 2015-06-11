module Liftoff
  class DependencyManager
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def setup
      raise NotImplementedError.new("#{self.class}#setup must be implemented.")
    end

    def install
      raise NotImplementedError.new("#{self.class}#install must be implemented.")
    end

    def run_script_phases
      []
    end
  end
end
