require 'rspec'
require 'liftoff'

describe Liftoff::OptionParser do
  describe "#options" do
    let(:defaults) { described_class.new.options }

    it "should have git true" do
      defaults[:git].should be true
    end

    it "should have error true" do
      defaults[:error].should be true
    end

    it "should have todo true" do
      defaults[:todo].should be true
    end

    it "should have warnings true" do
      defaults[:warnings].should be true
    end

    it "should have staticanalyzer true" do
      defaults[:staticanalyzer].should be true
    end

    it "should have indentation set to 4" do
      defaults[:indentation].should eq(4)
    end
  end

  describe "#options" do
    before do
      @option_parser = Liftoff::OptionParser.new

      @option_parser.stub(:default_options) { { :pasta => 1, :beer => 1, :cheese_cake => 1 } }
      @option_parser.stub(:user_options) { { :pasta => 0, :pizza => 2 } }
      @option_parser.stub(:local_options) { { :beer => 2, :cheese_cake => 2 } }
    end

    it "returns a set of options evaluated starting form pwd, falling back to home, falling back to defaults" do
      expected_options = { :pasta => 0, :pizza => 2, :beer => 2, :cheese_cake => 2 }
      @option_parser.options.should eq(expected_options)
    end

    it "doesn't break in case the pwd options are missing" do
      @option_parser.stub(:local_options) { {} }
      expected_options = { :pasta => 0, :pizza => 2, :beer => 1, :cheese_cake => 1 }
      @option_parser.options.should eq(expected_options)
    end

    it "doesn't break in case the home options are missing" do
      @option_parser.stub(:user_options) { {} }
      expected_options = { :pasta => 1, :beer => 2, :cheese_cake => 2 }
      @option_parser.options.should eq(expected_options)
    end
  end
end
