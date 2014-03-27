module Liftoff
  class ConfigurationParser

    def initialize(cli_options)
      @cli_options = cli_options
    end

    def project_configuration
      @configuration ||= evaluated_configuration
    end

    private

    def evaluated_configuration
      default_configuration
        .merge(user_configuration)
        .merge(local_configuration)
        .merge(@cli_options)
    end

    def default_configuration
      configuration_from_file(File.expand_path('../../../defaults/liftoffrc', __FILE__))
    end

    def user_configuration
      configuration_from_file(ENV['HOME'] + '/.liftoffrc')
    end

    def local_configuration
      configuration_from_file(Dir.pwd + '/.liftoffrc')
    end

    def configuration_from_file(path)
      if File.exists? path
        configuration = YAML.load_file(path)
        with_symbolized_keys(configuration)
      else
        {}
      end
    end

    def with_symbolized_keys(hash)
      Hash[hash.map { |key, value| [key.to_sym, value] }]
    end
  end
end
