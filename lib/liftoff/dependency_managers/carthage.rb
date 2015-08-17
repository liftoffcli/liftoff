module Liftoff
  class Carthage < DependencyManager
    def setup
      if carthage_installed?
        move_cartfile
      else
        puts 'Please install Carthage or disable carthage from liftoff'
      end
    end

    def install
      if carthage_installed?
        run_carthage_update
      end
    end

    def run_script_phases
      [
        {
          "file" => "copy_frameworks.sh",
          "name" => "Copy frameworks (Carthage)",
        }
      ]
    end

    private

    def carthage_installed?
      system('which carthage > /dev/null')
    end

    def move_cartfile
      FileManager.new.generate('Cartfile', 'Cartfile', @config)
    end

    def run_carthage_update
      puts 'Running carthage update'
      system('carthage update')
    end
  end
end
