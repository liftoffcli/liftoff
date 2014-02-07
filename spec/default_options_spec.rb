require 'rspec'
require 'liftoff'

describe DefaultOptions do
  describe "#default_options" do
    before(:all) do
      @defaults = DefaultOptions.new.default_options
    end

    it "should have git true" do
      @defaults[:git].should be true
    end

    it "should have error true" do
      @defaults[:error].should be true
    end

    it "should have todo true" do
      @defaults[:todo].should be true
    end

    it "should have warnings true" do
      @defaults[:warnings].should be true
    end

    it "should have staticanalyzer true" do
      @defaults[:staticanalyzer].should be true
    end

    it "should have indentation set to 4" do
      @defaults[:indentation].should eq(4)
    end
  end

  describe "#user_default_options" do
    before(:each) do
      @options_helper = DefaultOptions.new
      
      @options_helper.stub(:default_options) { { :pasta => 1, :beer => 1, :cheese_cake => 1 } }
      @options_helper.stub(:options_from_home) { { :pasta => 0, :pizza => 2 } }
      @options_helper.stub(:options_from_pwd) { { :beer => 2, :cheese_cake => 2 } }
      @options_helper.stub(:filter_valid_options).with(anything()) { anything() }
    end

    it "returns a set of options evaluated starting form pwd, falling back to home, falling back to defaults" do
      expected_options = { :pasta => 0, :pizza => 2, :beer => 2, :cheese_cake => 2 }
      @options_helper.user_default_options.should eq(expected_options)
    end

    it "doesn't break in case the pwd options are missing" do
      @options_helper.stub(:options_from_pwd) { {} }
      expected_options = { :pasta => 0, :pizza => 2, :beer => 1, :cheese_cake => 1 }
      @options_helper.user_default_options.should eq(expected_options)
    end

    it "doesn't break in case the home options are missing" do
      @options_helper.stub(:options_from_home) { {} }
      expected_options = { :pasta => 1, :beer => 2, :cheese_cake => 2 }
      @options_helper.user_default_options.should eq(expected_options)
    end
  end

  describe "#filter_valid_options" do 
    it "filters invalid options from a list of options" do
      any_valid_options = { :git => true, "error" => true }
      any_invalid_options = { :invalid_options => "pizza maragherita", :invalid_number => 42 }
      any_options = any_valid_options.merge(any_invalid_options)
      
      options = DefaultOptions.new.filter_valid_options(any_options)
      options.should(eq(any_valid_options))
    end 
  end
end
