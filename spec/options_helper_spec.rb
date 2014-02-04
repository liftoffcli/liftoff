require 'rspec'
require 'liftoff'

describe OptionsHelper do
  describe "#filter_valid_options" do 
    it "filters invalid options from a list of options" do
      any_valid_options = { :git => true, "error" => true }
      any_invalid_options = { :invalid_options => "pizza maragherita", :invalid_number => 42 }
      any_options = any_valid_options.merge(any_invalid_options)
      
      options = OptionsHelper.new.filter_valid_options(any_options)
      options.should(eq(any_valid_options))
    end 
  end
end