module Liftoff
  class LaunchPad
    def initialize
      liftoffrc = ConfigurationParser.new.project_configuration
      @config = ProjectConfiguration.new(liftoffrc)
    end

    def liftoff
      if project_exists?
        perform_project_actions
      else
        fetch_options

        file_manager.create_project_dir(@config.project_name) do
          generate_project
          perform_project_actions
          open_project
        end
      end
    end

    private

    def fetch_options
      @config.project_name = ask('Project name? ') { |q| q.default = @config.project_name }
      @config.company = ask('Company name? ') { |q| q.default = @config.company }
      @config.author = ask('Author name? ') { |q| q.default = @config.author }
      @config.prefix = ask('Prefix? ') { |q| q.default = @config.prefix }.upcase
    end

    def perform_project_actions
      set_indentation_level
      enable_warnings
      treat_warnings_as_errors
      add_todo_script_phase
      enable_static_analyzer
      install_cocoapods
      generate_git
    end

    def install_cocoapods
      CocoapodsHelper.new(@config).install_cocoapods(@config.use_cocoapods)
    end

    def generate_project
      ProjectBuilder.new(@config).create_project
    end

    def generate_git
      GitSetup.new(@config.configure_git).setup
    end

    def set_indentation_level
      xcode_helper.set_indentation_level(@config.indentation_level)
    end

    def treat_warnings_as_errors
      xcode_helper.treat_warnings_as_errors(@config.warnings_as_errors)
    end

    def add_todo_script_phase
      xcode_helper.add_todo_script_phase(@config.install_todo_script)
    end

    def enable_warnings
      xcode_helper.enable_warnings(@config.warnings)
    end

    def enable_static_analyzer
      xcode_helper.enable_static_analyzer(@config.enable_static_analyzer)
    end
    
    def open_project
      `open -a "Xcode" .`
    end

    def save_project
      xcode_helper.save
    end

    def project_exists?
      Dir.glob('*.xcodeproj').count > 0
    end

    def xcode_helper
      @xcode_helper ||= XcodeprojHelper.new
    end

    def file_manager
      @file_manager ||= FileManager.new
    end
  end
end
