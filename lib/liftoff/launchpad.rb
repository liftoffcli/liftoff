require 'optparse'

module Liftoff
  class LaunchPad
    def initialize(argv)
      parse_command_line_options(argv)
    end

    def liftoff
      @config = ConfigurationParser.new.project_configuration

      if @config[:git]
        generate_git
      end

      if @config[:indentation]
        set_indentation_level
      end

      if @config[:errors]
        treat_warnings_as_errors
      end

      if @config[:warnings]
        enable_warnings
      end

      if @config[:todo]
        add_todo_script_phase
      end

      if @config[:staticanalyzer]
        enable_static_analyzer
      end
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
      FileManager.new.create_git_files
    end

    def set_indentation_level
      xcode_helper.set_indentation_level(@config[:indentation])
    end

    def treat_warnings_as_errors
      xcode_helper.treat_warnings_as_errors
    end

    def add_todo_script_phase
      xcode_helper.add_todo_script_phase
    end

    def enable_warnings
      xcode_helper.enable_warnings
    end

    def enable_static_analyzer
      xcode_helper.enable_static_analyzer
    end

    def xcode_helper
      @xcode_helper ||= XcodeprojHelper.new(@opts)
    end

    def turn_on_all_options?
      @opts[:all]
    end

    def user_passed_no_flags?
      @opts.to_hash.values.compact.empty?
    end
  end
end
