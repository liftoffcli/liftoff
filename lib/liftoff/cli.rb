require 'optparse'

module Liftoff
  class CLI
    def initialize(argv)
      @argv = argv
    end

    def run
      parse_command_line_options
      Launchpad.new.liftoff
    end

    private

    def parse_command_line_options
      global_options.parse!(@argv)
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
  end
end
