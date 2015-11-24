require "spec_helper"

RSpec.describe Liftoff::Bundler do
  describe "#setup" do
    it "checks to see if bundler is installed" do
      system_call = "which bundle > /dev/null"
      bundler = Liftoff::Bundler.new(:config)
      allow(bundler).to receive(:system).with(system_call)

      bundler.setup

      expect(bundler).to have_received(:system).with(system_call)
    end

    context "when bundler is installed" do
      it "asks FileManager to move the Gemfile" do
        bundler = Liftoff::Bundler.new(:config)
        allow(bundler).to receive(:bundler_installed?).and_return(true)
        arguments = ["Gemfile.rb", "Gemfile", :config]
        file_manager = double("FileManager")
        allow(Liftoff::FileManager).to receive(:new).and_return(file_manager)
        allow(file_manager).to receive(:generate).with(*arguments)

        bundler.setup

        expect(file_manager).to have_received(:generate).with(*arguments)
      end
    end

    context "when bundler is not installed" do
      it "puts a message out to the system" do
        bundler = Liftoff::Bundler.new(:config)
        output_string = "Please install Bundler or disable bundler from liftoff"
        allow(bundler).to receive(:bundler_installed?).and_return(false)
        allow(bundler).to receive(:puts).with(output_string)

        bundler.setup

        expect(bundler).to have_received(:puts).with(output_string)
      end
    end
  end

  describe "#install" do
    context "if bundler is installed" do
      it "runs bundle install" do
        bundler = Liftoff::Bundler.new(:config)
        allow(bundler).to receive(:bundler_installed?).and_return(true)
        system_call = "bundle install"
        allow(bundler).to receive(:system).with(system_call)

        bundler.install

        expect(bundler).to have_received(:system).with(system_call)
      end
    end

    context "if bundler is not installed" do
      it "does not run bundle install" do
        bundler = Liftoff::Bundler.new(:config)
        allow(bundler).to receive(:bundler_installed?).and_return(false)
        allow(bundler).to receive(:system)

        bundler.install

        expect(bundler).not_to have_received(:system)
      end
    end
  end
end
