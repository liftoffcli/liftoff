require 'yaml'

class DefaultOptions

  def default_options
    options_from_file( File.join(File.dirname(File.expand_path(__FILE__)), '../defaults/liftoffrc') )
  end

  def options_from_pwd
    options_from_file(Dir.pwd + '/.liftoffrc')
  end

  def options_from_home
    options_from_file(ENV['HOME'] + "/.liftoffrc")
  end

  def user_default_options
    evaluated_options = default_options
    evaluated_options.merge!(options_from_home)
    evaluated_options.merge!(options_from_pwd)

    filter_valid_options evaluated_options
  end

  def filter_valid_options(options)
    valid_options = default_options.keys
    options.select { |key, value| (valid_options.include?(key.to_s) || valid_options.include?(key.to_sym)) }
  end

  private

  def options_from_file(path)
    if File.exists? path
      options = YAML.load_file(path)
      convert_keys_symbols options
    else
      options = { }
    end
  end

  def convert_keys_symbols(hash)
    Hash[hash.map { |key, value| [key.to_sym, value] }]
  end
end
