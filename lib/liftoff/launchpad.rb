module Liftoff
  class LaunchPad
    def initialize(argv)
      parse_options(argv)
    end

    def liftoff
      if @opts[:help]
        display_help
      elsif @opts[:version]
        display_version
      else
        if @opts[:git]
          generate_git
        end

        if @opts[:indentation]
          set_indentation_level
        end

        if @opts[:errors]
          treat_warnings_as_errors
        end

        if @opts[:todo]
          add_todo_script_phase
        end

        if @opts[:warnings]
          enable_hosey_warnings
        end

        if @opts[:staticanalyzer]
          enable_static_analyzer
        end
      end
    end

    private

    def parse_options(argv)
      @opts = Slop.parse(argv, :strict => true) do
        on :v, :version, 'Print the version'
        on :a, :all, 'Run all commands (Default)'
        on :g, :git, 'Add default .gitignore and .gitattributes files'
        on :i, :indentation=, 'Set the indentation level (in spaces, defaults to 4)', :argument => :optional, :as => Integer do |user_indentation_level|
          fetch_option(:indentation).value = user_indentation_level || DEFAULT_INDENTATION_LEVEL
        end
        on :e, :error, 'Treat warnings as errors (Only for release configurations)'
        on :t, :todo, 'Add a build script to turn TODO and FIXME comments into warnings'
        on :w, :warnings, 'Turn on Hosey warnings at the project level'
        on :s, :staticanalyzer, 'Turn on static analysis for the project'
        on :h, :help, 'Display this help message'
      end

      if @opts.to_hash.values.compact.empty? || @opts[:all]
        turn_on_all_options
      end
    end

    def display_help
      puts @opts.help
    end

    def display_version
      puts "Version: #{Liftoff::VERSION}"
    end

    def generate_git
      GitHelper.new.generate_files
    end

    def set_indentation_level
      xcode_helper.set_indentation_level(@opts[:indentation])
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

    def turn_on_all_options
      options_helper = OptionsHelper.new
      options = options_helper.options_from_pwd
      options ||= options_helper.options_from_home
      options ||= options_helper.default_options

      options = options_helper.filter_valid_options(options)

      options.each do |option, value|
        @opts.fetch_option(option.to_sym).value = value
      end
    end

  end
end
