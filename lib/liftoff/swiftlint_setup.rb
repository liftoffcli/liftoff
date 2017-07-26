module Liftoff
  class SwiftLintSetup
    def initialize(config)
      @config = config
    end

    def setup
      if @config.configure_swiftlint
        if swiftlint_installed?
          generate_files
        else
          puts 'Please install Swiftlint or disable from liftoff'
        end
      end
    end

    def run_script_phases
      [
        {
          "file" => "swiftlint.sh",
          "name" => "Execute SwiftLint",
        }
      ]
    end

    private

    def generate_files
      file_manager.generate('swiftlint', '.swiftlint.yml', @config)
    end

    def swiftlint_installed?
      system('which swiftlint > /dev/null')
    end

    def file_manager
      @file_manager ||= FileManager.new
    end
  end
end
