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

  describe "#evaluated_options" do
    it "returns a set of options evaluated starting form pwd, falling back to home, falling back to defaults" do
      options_helper = OptionsHelper.new
      
      options_helper.stub(:default_options) { { :pasta => 1, :beer => 1, :cheese_cake => 1 } }
      options_helper.stub(:options_from_home) { { :pasta => 0, :pizza => 2 } }
      options_helper.stub(:options_from_pwd) { { :beer => 2, :cheese_cake => 2 } }
      options_helper.stub(:filter_valid_options).with(anything()) { anything() }
      
      expected_options = { :pasta => 0, :pizza => 2, :beer => 2, :cheese_cake => 2 }
      options_helper.evaluated_options.should eq(expected_options)
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