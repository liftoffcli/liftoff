
class OptionsHelper

  def default_options
    settings = {  
      :git => true, 
      :error => true,
      :todo => true,
      :warnings => true,
      :staticanalyzer => true,
      :indentation => 4
    }
  end

  def filter_valid_options(options)
    valid_options = default_options.keys
    options.select { |key, value| valid_options.include?(key) || valid_options.include?(key.to_sym) }
  end

  def options_from_pwd
    options_from_file(Dir.pwd + '/.liftoffrc')
  end

  def options_from_home
    options_from_file(ENV['HOME'] + "/.liftoffrc")
  end

  private

  def options_from_file(path)
    if File.exists? path
      puts "Reading liftoff configurations from #{path}\n\n"
      options = JSON.parse(IO.read(path))
    end
  end
end