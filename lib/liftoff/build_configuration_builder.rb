module Liftoff
  class BuildConfigurationBuilder
    def initialize(xcode_project)
      @xcode_project = xcode_project
    end

    def generate_build_configuration(name, type)
      @xcode_project.add_build_configuration(name, type.to_sym)
    end

    def generate_build_configurations(build_configurations)
      build_configurations ||= []
      build_configurations.each do |configuration|
        name = configuration["name"]
        type = configuration["type"]
        generate_build_configuration(name, type)
      end
    end
  end
end
