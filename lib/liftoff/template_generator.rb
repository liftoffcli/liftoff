module Liftoff
  class TemplateGenerator
    def generate_templates(config, file_manager)
      if config.templates
        config.each_template do |source, destination|
          file_manager.generate(source, destination, config)
        end
      end
    end
  end
end
