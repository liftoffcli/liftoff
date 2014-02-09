require 'yaml'

module Liftoff
  class OptionParser

    def options
      @options ||= evaluated_options
    end

    private

    def default_options
      options_from_file(File.expand_path('../../../defaults/liftoffrc', __FILE__))
    end

    def local_options
      options_from_file(Dir.pwd + '/.liftoffrc')
    end

    def user_options
      options_from_file(ENV['HOME'] + '/.liftoffrc')
    end

    def evaluated_options
      default_options.
        merge(user_options).
        merge(local_options)
    end

    def options_from_file(path)
      if File.exists? path
        options = YAML.load_file(path)
        with_symbolized_keys(options)
      else
        {}
      end
    end

    def with_symbolized_keys(hash)
      Hash[hash.map { |key, value| [key.to_sym, value] }]
    end
  end
end
