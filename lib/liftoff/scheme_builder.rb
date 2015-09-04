module Liftoff
  class SchemeBuilder
    def initialize(xcode_project, config)
      @xcode_project = xcode_project
      @config = config
    end

    def create_schemes
      xcode_project.generate_default_scheme
    
      config_schemes.each do |scheme_config|
        name = name_from_scheme_config(scheme_config)
        generate_scheme(name, scheme_config["actions"])
      end
    end

    private

    attr_reader :xcode_project, :config

    def config_schemes
      config.schemes || []
    end

    def name_from_scheme_config(scheme_config)
      string_renderer.render(scheme_config["name"])
    end

    def generate_scheme(name, actions)
      actions ||= []
      xcode_project.generate_scheme(name) do |scheme|
        actions.each do |action, action_config|
          add_action_to_scheme(action, action_config, scheme)
        end
      end
    end

    def add_action_to_scheme(action, action_config, scheme)
      action_elem = action_from_scheme(action, scheme)
    
      build_configuration = action_config["build_configuration"]
      if build_configuration
        action_elem.build_configuration = build_configuration
      end
    end

    def action_from_scheme(action_name, scheme)
      scheme.send("#{action_name.downcase}_action")
    end

    def string_renderer
      @renderer ||= StringRenderer.new(config)
    end
  end
end
