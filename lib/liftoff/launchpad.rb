module Liftoff
  class LaunchPad
    def initialize(argv)
      @opts = parse_options(argv)
    end

    def liftoff
      @config = OptionParser.new.options

      if @opts[:help]
        display_help
      elsif @opts[:version]
        display_version
      else
        if @config[:git]
          generate_git
        end

        if @config[:indentation]
          set_indentation_level
        end

        if @config[:errors]
          treat_warnings_as_errors
        end

        if @config[:todo]
          add_todo_script_phase
        end

        if @config[:warnings]
          enable_hosey_warnings
        end

        if @config[:staticanalyzer]
          enable_static_analyzer
        end
      end
    end

    private

    def parse_options(argv)
      Slop.parse(argv, :strict => true) do
        on :v, :version, 'Print the version'
        on :h, :help, 'Display this help message'
      end
    end

    def display_help
      puts @opts.help
    end

    def display_version
      puts "Version: #{Liftoff::VERSION}"
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

    def enable_hosey_warnings
      xcode_helper.enable_hosey_warnings
    end

    def enable_static_analyzer
      xcode_helper.enable_static_analyzer
    end

    def xcode_helper
      @xcode_helper ||= XcodeprojHelper.new
    end

    def turn_on_all_options?
      @opts[:all]
    end

    def user_passed_no_flags?
      @opts.to_hash.values.compact.empty?
    end
  end
end
