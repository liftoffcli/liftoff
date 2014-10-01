module Liftoff
  class ConfigurationParser

    TEMPLATE_GROUPS = [:app_target_templates, :test_target_templates]

    def initialize(options)
      @options = options
    end

    def project_configuration
      @configuration ||= evaluated_configuration
    end

    private

    def evaluated_configuration
      initial_configuration.merge(template_groups_configuration)
    end

    def initial_configuration
      default_configuration
        .merge(user_configuration)
        .merge(local_configuration)
        .merge(@options)
    end

    def template_groups_configuration
      TEMPLATE_GROUPS.inject({}) do |acc, key|
        acc.merge(key => evaluated_templates(key))
      end
    end

    def evaluated_templates(key)
      default_configuration[key]
      .merge(user_configuration[key])
      .merge(local_configuration[key])
    end

    def default_configuration
      @default ||= configuration_from_file(File.expand_path('../../../defaults/liftoffrc', __FILE__))
    end

    def user_configuration
      @user ||= configuration_from_file(ENV['HOME'] + '/.liftoffrc')
    end

    def local_configuration
      @local ||= configuration_from_file(Dir.pwd + '/.liftoffrc')
    end

    def configuration_from_file(path)
      hash = if File.exists? path
        configuration = YAML.load_file(path)
        with_symbolized_keys(configuration)
      else
        Hash.new
      end

      with_default_values(hash)
    end

    def with_symbolized_keys(hash)
      Hash[hash.map { |key, value| [key.to_sym, value] }]
    end

    def with_default_values(hash)
      hash.default = {}
      hash
    end
  end
end
