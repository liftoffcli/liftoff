require 'spec_helper'

describe Liftoff::ConfigurationParser do
  describe "#project_configuration" do
    let (:parser) { described_class.new }

    before do
      parser.stub(:default_configuration) { { :pasta => 1, :beer => 1, :cheese_cake => 1 } }
      parser.stub(:user_configuration) { { :pasta => 0, :pizza => 2 } }
      parser.stub(:local_configuration) { { :beer => 2, :cheese_cake => 2 } }
    end

    it "returns a set of project_configuration evaluated starting form pwd, falling back to home, falling back to defaults" do
      expected_project_configuration = { :pasta => 0, :pizza => 2, :beer => 2, :cheese_cake => 2 }
      parser.project_configuration.should eq(expected_project_configuration)
    end

    it "doesn't break in case the pwd project_configuration are missing" do
      parser.stub(:local_configuration) { {} }
      expected_project_configuration = { :pasta => 0, :pizza => 2, :beer => 1, :cheese_cake => 1 }
      parser.project_configuration.should eq(expected_project_configuration)
    end

    it "doesn't break in case the home project_configuration are missing" do
      parser.stub(:user_configuration) { {} }
      expected_project_configuration = { :pasta => 1, :beer => 2, :cheese_cake => 2 }
      parser.project_configuration.should eq(expected_project_configuration)
    end
  end
end
