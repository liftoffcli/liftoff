module Liftoff
  class CocoapodsSetup
    def install_cocoapods(use_cocoapods)
      if use_cocoapods
        if pod_installed?
          move_podfile
          run_pod_install
        else
          puts 'Please install CocoaPods or disable pods from liftoff'
        end
      end
    end

    private

    def pod_installed?
      system('which pod')
    end

    def move_podfile
      FileManager.new.generate('Podfile', 'Podfile')
    end

    def run_pod_install
      puts 'Running pod install'
      system('pod install')
    end
  end
end
