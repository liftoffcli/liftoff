module Liftoff
  class StringRenderer
    def initialize(config)
      @config = config
    end

    def render(string)
      ERB.new(string).result(@config.get_binding)
    end
  end
end
