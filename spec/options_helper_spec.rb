require 'rspec'
require 'liftoff'

describe OptionsHelper do
  describe "#default_options" do
    before(:all) do
      @defaults = OptionsHelper.new.default_options
    end

    it "should have git true" do
      @defaults['git'].should be true
    end

    it "should have error true" do
      @defaults['error'].should be true
    end

    it "should have todo true" do
      @defaults['todo'].should be true
    end

    it "should have warnings true" do
      @defaults['warnings'].should be true
    end

    it "should have staticanalyzer true" do
      @defaults['staticanalyzer'].should be true
    end

    it "should have indentation set to 4" do
      @defaults['indentation'].should eq(4)
    end
  end

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