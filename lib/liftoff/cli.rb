module Liftoff
  class CLI
    def initialize(argv)
      @argv = argv
      @options = {}
    end

    def run
      parse_command_line_options
      LaunchPad.new.liftoff @options
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

        opts.on('--[no-]cocoapods', 'Enable/Disable Cocoapods') do |use_cocoapods|
          @options[:use_cocoapods] = use_cocoapods
        end

        opts.on('--[no-]git', 'Enable/Disable git') do |configure_git|
          @options[:configure_git] = configure_git
        end

        # Integer Options

        opts.on('-t', '--indentation N', 'Set indentation level') do |indentation_level|
          @options[:indentation_level] = indentation_level
        end

        # String Options

        opts.on('-n', '--name [PROJECT_NAME]', 'Set project name') do |name|
          @options[:project_name] = name
        end

        opts.on('-c', '--company [COMPANY]', 'Set project company') do |company|
          @options[:company] = company
        end

        opts.on('-a', '--author [AUTHOR]', 'Set project author') do |author|
          @options[:author] = author
        end

        opts.on('-p', '--prefix [PREFIX]', 'Set project prefix') do |prefix|
          @options[:prefix] = prefix
        end

        opts.on('-i', '--identifier [IDENTIFIER]', 'Set project company ID (com.example)') do |identifier|
          @options[:company_identifier] = identifier
        end
      end
    end
  end
end
