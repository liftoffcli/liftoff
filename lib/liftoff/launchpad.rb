module Liftoff
  class LaunchPad
    def initialize
      @config = ConfigurationParser.new.project_configuration
    end

    def liftoff
      generate_git
      set_indentation_level
      enable_warnings
      treat_warnings_as_errors
      add_todo_script_phase
      enable_static_analyzer
    end

    private

    def generate_git
      FileManager.new.create_git_files(@config[:git])
    end

    def set_indentation_level
      xcode_helper.set_indentation_level(@config[:indentation])
    end

    def treat_warnings_as_errors
      xcode_helper.treat_warnings_as_errors(@config[:errors])
    end

    def add_todo_script_phase
      xcode_helper.add_todo_script_phase(@config[:todo])
    end

    def enable_warnings
      xcode_helper.enable_warnings(@config[:warnings])
    end

    def enable_static_analyzer
      xcode_helper.enable_static_analyzer(@config[:staticanalyzer])
    end

    def xcode_helper
      @xcode_helper ||= XcodeprojHelper.new
    end
  end
end
