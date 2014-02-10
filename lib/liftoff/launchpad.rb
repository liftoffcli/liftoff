require 'optparse'

module Liftoff
  class LaunchPad
    def initialize(argv)
      parse_command_line_options(argv)
    end

    def liftoff
      @config = ConfigurationParser.new.project_configuration

      generate_git
      set_indentation_level
      enable_warnings
      treat_warnings_as_errors
      add_todo_script_phase
      enable_static_analyzer
    end

    private

    def parse_command_line_options(argv)
      global_options.parse!(argv)
    end

    def global_options
      OptionParser.new do |opts|
        opts.banner = 'usage: liftoff [-v | --version] [-h | --help]'

        opts.on('-v', '--version', 'Display the version and exit') do
          puts "Version: #{Liftoff::VERSION}"
          exit 0
        end

        opts.on('-h', '--help', 'Display this help message and exit') do
          puts opts
          exit 0
        end
      end
    end

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
