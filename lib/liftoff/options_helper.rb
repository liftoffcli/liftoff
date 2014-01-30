
class OptionsHelper

  def self.default_options
    settings = {  
      :git => true, 
      :error => true,
      :todo => true,
      :warnings => true,
      :staticanalyzer => true,
      :indentation => 4
    }
  end

  def self.filter_valid_options options
    valid_options = default_options.keys
    options.select { |key, value| (valid_options.include? key or valid_options.include? key.to_sym) }
  end

  def self.options_from_pwd verbose=true
    options_from_file Dir.pwd + '/.liftoffrc'
  end

  def self.options_from_home verbose=true
    options_from_file ENV['HOME'] + "/.liftoffrc"
  end

  private

  def self.options_from_file path, verbose=true
    if File.exists? path
      puts "Reading liftoff configurations from #{path}\n\n" if verbose
      options = JSON.parse IO.read path
    else 
      # maybe show warning in verbose mode?
    end
  end
end