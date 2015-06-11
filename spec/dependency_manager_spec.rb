require "spec_helper"

describe Liftoff::DependencyManager do
  describe "#setup" do
    it "raises an error when not implemented" do
      manager = InvalidDependencyManager.new(:config)

      expect { manager.setup }.to raise_error(NotImplementedError)
    end

    it "doesn't raise an error when implemented" do
      manager = ValidDependencyManager.new(:config)

      expect { manager.setup }.not_to raise_error
    end
  end

  describe "#install" do
    it "raises an error when not implemented" do
      manager = InvalidDependencyManager.new(:config)

      expect { manager.install }.to raise_error(NotImplementedError)
    end

    it "doesn't raise an error when implemented" do
      manager = ValidDependencyManager.new(:config)

      expect { manager.install }.not_to raise_error
    end
  end

  describe "#run_script_phases" do
    it "provides an empty array as a default" do
      manager = Liftoff::DependencyManager.new(:config)

      expect(manager.run_script_phases).to eq([])
    end
  end


  class InvalidDependencyManager < Liftoff::DependencyManager; end
  class ValidDependencyManager < Liftoff::DependencyManager;
    def install; end
    def setup; end
  end
end
