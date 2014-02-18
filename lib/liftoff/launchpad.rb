require 'fileutils'

module Liftoff
  class LaunchPad
    def initialize
      liftoffrc = ConfigurationParser.new.project_configuration
      @config = ProjectConfiguration.new(liftoffrc)
    end

    def liftoff
      fetch_options

      file_manager.create_project_dir(@config.name) do
        generate_project
        generate_git
        set_indentation_level
        enable_warnings
        treat_warnings_as_errors
        add_todo_script_phase
        enable_static_analyzer
      end
    end

    private

    def fetch_options
      @config.name = ask('Project name? ') { |q| q.default = @config.name }
      @config.company = ask('Company name? ') { |q| q.default = @config.company }
      @config.author = ask('Author name? ') { |q| q.default = @config.author }
      @config.prefix = ask('Prefix? ') { |q| q.default = @config.prefix }
    end

    def generate_project
      ProjectBuilder.new(@config).create_project
    end

    def generate_git
      GitSetup.new(@config.git).setup
    end

    def set_indentation_level
      xcode_helper.set_indentation_level(@config.indentation)
    end

    def treat_warnings_as_errors
      xcode_helper.treat_warnings_as_errors(@config.errors)
    end

    def add_todo_script_phase
      xcode_helper.add_todo_script_phase(@config.todo)
    end

    def enable_warnings
      xcode_helper.enable_warnings(@config.warnings)
    end

    def enable_static_analyzer
      xcode_helper.enable_static_analyzer(@config.staticanalyzer)
    end

    def xcode_helper
      @xcode_helper ||= XcodeprojHelper.new
    end
  end
end
