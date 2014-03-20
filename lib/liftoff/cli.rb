module Liftoff
  class CLI
    def initialize(argv)
      @argv = argv
      @liftoffrc = {}
    end

    def run
      parse_command_line_options
      LaunchPad.new.liftoff @liftoffrc
    end

    private

    def parse_command_line_options
      global_options.parse!(@argv)
    end

    def global_options
      OptionParser.new do |opts|
        opts.banner = 'usage: liftoff [-v | --version] [-h | --help] [config options]'

        opts.on('-v', '--version', 'Display the version and exit') do
          puts "Version: #{Liftoff::VERSION}"
          exit
        end

        opts.on('-h', '--help', 'Display this help message and exit') do
          puts opts
          exit
        end

        # Boolean Options

        opts.on('--[no-]cp', 'Enable/Disable Cocoapods') do |use_cocoapods|
          @liftoffrc[:use_cocoapods] = use_cocoapods
        end

        opts.on('--[no-]git', 'Enable/Disable git') do |configure_git|
          @liftoffrc[:configure_git] = configure_git
        end

        opts.on('--[no-]warnings', 'Enable/Disable warnings as errors') do |warnings_as_errors|
          @liftoffrc[:warnings_as_errors] = warnings_as_errors
        end

        opts.on('--[no-]todo-scripts', 'Enable/Disable installation of TODO scripts') do |install_todo_script|
          @liftoffrc[:install_todo_script] = install_todo_script
        end

        opts.on('--[no-]static-analyzer', 'Enable/Disable static analyzer') do |enable_static_analyzer|
          @liftoffrc[:enable_static_analyzer] = enable_static_analyzer
        end

        # Integer Options

        opts.on('-t', '--indentation_level N', 'Set indentation level') do |indentation_level|
          @liftoffrc[:indentation_level] = indentation_level
        end

        # String Options

        opts.on('-n', '--project_name [PROJECT_NAME]', 'Set project name') do |name|
          @liftoffrc[:project_name] = name
        end

        opts.on('-c', '--company [COMPANY]', 'Set project company') do |company|
          @liftoffrc[:company] = company
        end

        opts.on('-a', '--author [AUTHOR]', 'Set project author') do |author|
          @liftoffrc[:author] = author
        end

        opts.on('-p', '--prefix [PREFIX]', 'Set project prefix') do |prefix|
          @liftoffrc[:prefix] = prefix
        end

        opts.on('-i', '--identifier [IDENTIFIER]', 'Set project company ID (com.example)') do |identifier|
          @liftoffrc[:company_identifier] = identifier
        end
      end
    end
  end
end
