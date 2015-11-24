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
      @options[:path] = @argv.first
    end

    def global_options
      OptionParser.new do |opts|
        opts.banner = 'usage: liftoff [-v | --version] [-h | --help] [config options] [path]'

        opts.on('-v', '--version', 'Display the version and exit') do
          puts "Version: #{Liftoff::VERSION}"
          exit
        end

        opts.on('-h', '--help', 'Display this help message and exit') do
          puts opts
          exit
        end

        opts.on('--[no-]strict-prompts', 'Enable/Disable strict prompts') do |strict_prompts|
          @options[:strict_prompts] = strict_prompts
        end

        opts.on('--dependency-managers [NAME(s)]',
                "Comma separated list of dependency managers to enable.\
 Available options: cocoapods,carthage,bundler") do |list|
          @options[:dependency_managers] = (list || "").split(",")
        end

        opts.on('--[no-]cocoapods', 'Enable/Disable Cocoapods') do |use_cocoapods|
          @options[:dependency_managers] ||= []

          if use_cocoapods
            @options[:dependency_managers] += ["cocoapods"]
          else
            @options[:dependency_managers] -= ["cocoapods"]
          end
        end

        opts.on('--[no-]git', 'Enable/Disable git') do |configure_git|
          @options[:configure_git] = configure_git
        end

        opts.on('--no-open', "Don't open Xcode after generation") do
          @options[:xcode_command] = false
        end

        opts.on('--[no-]settings', 'Enable/Disable Settings.bundle') do |enable_settings|
          @options[:enable_settings] = enable_settings
        end

        opts.on('--template [TEMPLATE NAME]', 'Use the specified project template') do |template_name|
          @options[:project_template] = template_name
        end

        opts.on('-t', '--indentation N', 'Set indentation level') do |indentation_level|
          @options[:indentation_level] = indentation_level
        end

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

        opts.on('--test-target-name [TEST_TARGET_NAME]', 'Set the name of the unit test target') do |test_target_name|
          @options[:test_target_name] = test_target_name
        end
      end
    end
  end
end
