require "spec_helper"

describe Liftoff::BuildConfigurationBuilder do
  describe "#generate_build_configuration" do
    it "creates a build configuration" do
      project = double("xcodeproj")
      builder = build_configuration_builder(project)

      allow(project).to receive(:add_build_configuration)

      builder.generate_build_configuration("Release-CI", :release)

      expect(project).to have_received(:add_build_configuration).with("Release-CI", :release)
    end
  end

  describe "#generate_build_configurations" do
    it "creates multiple build configurations" do
      project = double("xcodeproj")
      builder = build_configuration_builder(project)

      allow(project).to receive(:add_build_configuration)

      builder.generate_build_configurations(build_configurations)

      expect(project).to have_received(:add_build_configuration).with("Release-CI", :release)
      expect(project).to have_received(:add_build_configuration).with("Debug-CI", :debug)
    end
  end

  def build_configurations
    [
        {
            "name" => "Release-CI",
            "type" => "release",
        },
        {
            "name" => "Debug-CI",
            "type" => "debug",
        },
    ]
  end

  def build_configuration_builder(project)
    Liftoff::BuildConfigurationBuilder.new(project)
  end
end
