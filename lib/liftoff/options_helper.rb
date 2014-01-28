
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
end