require 'spec_helper'

describe Liftoff::ConfigurationParser do
  describe '#project_configuration' do
    it 'returns a hash evaluated from the local, user, default, and command line configurations' do
      stub_and_override(:user, :local)

      parser = Liftoff::ConfigurationParser.new(cli_options)

      expected = { :pasta => 0, :pizza => 2, :beer => 0, :cheese_cake => 2 , :whiskey => 1 }
      expect(parser.project_configuration).to eq expected
    end

    it 'falls back to the user config if no command line options were passed' do
      stub_and_override(:user, :local)

      parser = Liftoff::ConfigurationParser.new({})

      expected = { :pasta => 0, :beer => 2, :pizza => 2, :cheese_cake => 2 }
      expect(parser.project_configuration).to eq expected
    end

    it 'falls back to the user configuration if the local configuration is missing' do
      stub_and_override(:user)

      parser = Liftoff::ConfigurationParser.new(cli_options)

      expected = { :pasta => 0, :pizza => 2, :beer => 0, :cheese_cake => 1 , :whiskey => 1}
      expect(parser.project_configuration).to eq expected
    end

    it 'falls back to the default if the user configuration is missing' do
      stub_and_override(:local)

      parser = Liftoff::ConfigurationParser.new(cli_options)

      expected_project_configuration = { :pasta => 1, :beer => 0, :cheese_cake => 2 , :whiskey => 1 }
      parser.project_configuration.should eq(expected_project_configuration)
    end
  end

  def stub_and_override(*overrides)
    stub_defaults
    stub_user(overrides.include?(:user))
    stub_local(overrides.include?(:local))
  end

  def stub_defaults
    liftoffrc_path = File.expand_path('../../defaults/liftoffrc', __FILE__)
    default_configuration = { :pasta => 1, :beer => 1, :cheese_cake => 1 }
    stub_path(liftoffrc_path, default_configuration, true)
  end

  def stub_user(exists)
    liftoffrc_path = File.join(ENV['HOME'], '.liftoffrc')
    user_configuration = { :pasta => 0, :pizza => 2 }
    stub_path(liftoffrc_path, user_configuration, exists)
  end

  def stub_local(exists)
    liftoffrc_path = File.join(Dir.pwd, '.liftoffrc')
    local_configuration = { :beer => 2, :cheese_cake => 2 }
    stub_path(liftoffrc_path, local_configuration, exists)
  end

  def stub_path(path, result, exists)
    File.stub(:exists?).with(path) { exists }
    YAML.stub(:load_file).with(path) { result }
  end

  def cli_options
    { :beer => 0, :whiskey => 1 }
  end
end
