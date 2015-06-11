require "spec_helper"

describe Liftoff::DependencyManagerCoordinator do
  describe "#setup_dependencies" do
    it "sets up each depenency" do
      deps = mocked_dependencies
      manager = Liftoff::DependencyManagerCoordinator.new(deps)
      deps.each { |dep| allow(dep).to receive(:setup) }

      manager.setup_dependencies

      deps.each { |dep| expect(dep).to have_received(:setup) }
    end
  end

  describe "#install_dependencies" do
    it "installs each dependency" do
      deps = mocked_dependencies
      manager = Liftoff::DependencyManagerCoordinator.new(deps)
      deps.each { |dep| allow(dep).to receive(:install) }

      manager.install_dependencies

      deps.each { |dep| expect(dep).to have_received(:install) }
    end
  end

  describe "#run_script_phases_for_dependencies" do
    it "returns flattened run_script_phases for dependencies" do
      dependency_manager = double_dependency(run_script_phases: [1])
      dependency_manager2 = double_dependency(run_script_phases: [2])

      manager = Liftoff::DependencyManagerCoordinator.new(
        [dependency_manager, dependency_manager2]
      )

      phases = manager.run_script_phases_for_dependencies

      expect(phases).to eq([1,2])
    end
  end

  def mocked_dependencies
    [double_dependency, double_dependency]
  end

  def double_dependency(options = {})
     double("DependencyManager", options)
  end
end
