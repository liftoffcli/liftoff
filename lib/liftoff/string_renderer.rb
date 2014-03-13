module Liftoff
  class StringRenderer
    def initialize(configuration)
      @configuration = configuration
    end

    def render(string)
      ERB.new(string).result(@configuration.get_binding)
    end
  end
end
