require "spec_helper"

describe Liftoff::SchemeBuilder do
  describe "#create_schemes" do
    it "creates schemes with the right names" do
      project = double("xcodeproj")
      config = build_config("FakeApp", build_schemes)
      scheme_builder = scheme_builder(project, config)

      allow(project).to receive(:generate_default_scheme)
      allow(project).to receive(:generate_scheme)

      scheme_builder.create_schemes

      expect(project).to have_received(:generate_default_scheme).with(no_args)
      expect(project).to have_received(:generate_scheme).with("FakeApp-CI")
      expect(project).to have_received(:generate_scheme).with("FakeApp-AppStore")
    end

    it "add build configurations to actions" do
      project = double("xcodeproj")
      schemes = [build_scheme("<%= project_name %>-CI")]
      config = build_config("FakeApp", schemes)
      scheme_builder = scheme_builder(project, config)

      scheme = Xcodeproj::XCScheme.new

      allow(project).to receive(:generate_default_scheme)
      allow(project).to receive(:generate_scheme).and_yield(scheme)
      
      scheme_builder.create_schemes

      expect(project).to have_received(:generate_default_scheme).with(no_args)
      expect(project).to have_received(:generate_scheme).with("FakeApp-CI")

      expect(scheme.test_action.build_configuration).to eq "Debug-CI"
      expect(scheme.profile_action.build_configuration).to eq "Release-CI"
      expect(scheme.analyze_action.build_configuration).to eq "Debug-CI"
      expect(scheme.archive_action.build_configuration).to eq "Release-CI"
      expect(scheme.launch_action.build_configuration).to eq "Debug-CI"
    end

  end

  def scheme_builder(project, config)
    Liftoff::SchemeBuilder.new(project, config)
  end

  def build_config(name, schemes)
    Liftoff::ProjectConfiguration.new({
      :project_name => name,
      :schemes => schemes,
    })
  end

  def build_scheme(name)
    {
      "name" => name,
      "actions" => {
        "test" => {
          "build_configuration" => "Debug-CI"
        },
        "profile" => {
          "build_configuration" => "Release-CI"
        },
        "analyze" => {
          "build_configuration" => "Debug-CI"
        },
        "archive" => {
          "build_configuration" => "Release-CI"
        },
        "launch" => {
          "build_configuration" => "Debug-CI"
        }
      }
    }
  end

  def build_schemes
    [
      build_scheme("<%= project_name %>-CI"),
      build_scheme("<%= project_name %>-AppStore"),
    ]
  end
end
