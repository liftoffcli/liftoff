module Liftoff
  class TemplateGenerator
    def generate_templates(config, file_manager)
      if config.templates
        config.templates.each_pair do |template, destination|
          file_manager.generate(template, destination, config)
        end
      end
    end
  end
end
