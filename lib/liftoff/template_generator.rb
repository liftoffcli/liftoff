module Liftoff
  class TemplateGenerator
    def initialize(config)
      @config = config
    end

    def generate_templates(file_manager)
      if @config.templates
        @config.each_template do |source, destination|
          file_manager.generate(source, destination, @config)
        end
      end
    end
  end
end
